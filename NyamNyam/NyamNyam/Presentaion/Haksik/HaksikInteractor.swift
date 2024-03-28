//
//  HaksikInteractor.swift
//  NyamNyam
//
//  Created by 박준홍 on 2024/01/15.
//

import Foundation
import RIBs
import ReactorKit
import RxSwift
import RxCocoa

protocol HaksikRouting: ViewableRouting {
    func attachMealPlanCards(mealPlans: [MealPlan], cafeteriasID: [String])
    func detachMealPlanCards()
}

protocol HaksikPresentable: Presentable {
    var listener: HaksikPresentableListener? { get set }
}

protocol HaksikListener: AnyObject {
    
}

protocol HaksikInteractorDependency {
    var haksikService: HaksikService { get }
    var userDataService: UserDataService { get }
    var universityInfoService: UniversityInfoService { get }
    var mutableSelectedCafeteriaIDStream: MutableSelectedCafeteriaIDStream { get }
    var mutableSelectedDateStream: MutableSelectedDateStream { get }
}

final class HaksikInteractor: PresentableInteractor<HaksikPresentable>,
                              HaksikInteractable,
                              HaksikPresentableListener,
                              Reactor {
    private let dependency: HaksikInteractorDependency
    
    typealias Action = HaksikPresentableAction
    
    typealias State = HaksikPresentableState
    
    let initialState: HaksikPresentableState
    
    weak var router: HaksikRouting?
    
    weak var listener: HaksikListener?

    init(
        presenter: HaksikPresentable,
        dependency: HaksikInteractorDependency
    ) {
        self.initialState = State()
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    enum Mutation {
        case setLoading(Bool)
        case setRetryAlert(AlertInfo)
        case setSelectedDate(Date?)
        case setSelectedCafeteria(String?)
        case setFetchedHaskikData([MealPlan], UserUniversity, UniversityInfo)
        case attachMealPlanCards
        case detachMealPlanCards
    }
    
    func sendAction(_ action: Action) {
        self.action.onNext(action)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        case .viewDidAppear, .retryLoad, .appWillEnterForeground:
            return .concat([
                .just(.setLoading(true)),
                .just(.detachMealPlanCards),
                self.fetchHaksikDataTransform(),
                .just(.attachMealPlanCards),
                .just(.setLoading(false)),
            ])
            
        case let .dateSelected(date):
            dependency.mutableSelectedDateStream.updateDate(with: date)
            return .empty()
            
        case let .cafeteriaSelected(id):
            dependency.mutableSelectedCafeteriaIDStream.updateID(with: id)
            return .empty()
        }
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let didSelectCafeteria = dependency.mutableSelectedCafeteriaIDStream
            .selectedID
            .map { id -> Mutation in
                .setSelectedCafeteria(id)
            }
        
        let didSelectDate = dependency.mutableSelectedDateStream
            .selectedDate
            .map { date -> Mutation in
                .setSelectedDate(date)
            }
        
        return .merge([mutation, didSelectCafeteria, didSelectDate])
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .setRetryAlert(alertInfo):
            state.alertInfo = alertInfo
            
        case let .setLoading(status):
            state.isLoading = status
            
        case let .setSelectedDate(date):
            state.selectedDate = date
            
        case let .setSelectedCafeteria(id):
            let userData = currentState.userUniversityData
            let universityInfo = currentState.universityInfo
            let campusId = userData?.defaultCampusID
            state.selectedCafeteria = universityInfo?.campusInfos
                .first(where: { $0.id == campusId })?
                .cafeteriaInfos
                .first(where: { $0.id == id })
            
        case let .setFetchedHaskikData(mealPlans, userData, universityInfo):
            let campusID = userData.defaultCampusID
            let currentCampus = universityInfo.campusInfos
                .first { $0.id == campusID }
            let userCafeteriaIDs = userData.userCampuses
                .filter({ $0.id == userData.defaultCampusID })
                .first?
                .cafeteriaIDs
            let userCafeteriaInfos = userCafeteriaIDs?.compactMap { id in currentCampus?.cafeteriaInfos.first(
                where: { info in
                    info.id == id
                })
            }
            let availableDates =  mealPlans
                .filter({ mealPlan in
                    mealPlan.cafeterias
                        .filter({ cafeteria in
                            currentCampus?.cafeteriaInfos
                                .map({$0.id})
                                .contains(cafeteria.cafeteriaID) ?? false
                        })
                        .count > 0
                })
                .map { $0.date }
            
            state.mealPlans = mealPlans
            state.userUniversityData = userData
            state.universityInfo = universityInfo
            state.campusTitle = currentCampus?.name
            state.cafeteriaInfos = userCafeteriaInfos
            state.availableDates = availableDates
            
        case .attachMealPlanCards:
            if let mealPlans = state.mealPlans,
               let cafeteriaInfos = state.cafeteriaInfos {
                router?.attachMealPlanCards(
                    mealPlans: mealPlans,
                    cafeteriasID: cafeteriaInfos.map { $0.id }
                )
            }
            
        case .detachMealPlanCards:
            router?.detachMealPlanCards()
            
        }
        return state
    }
    
    private func fetchHaksikDataTransform() -> Observable<Mutation> {
        Observable.zip(
            dependency.haksikService.fetchMealPlans()
                .asObservable(),
            dependency.userDataService.getUserUniversityID()
                .asObservable()
                .withUnretained(self)
                .flatMap { owner, id in
                    owner.dependency.userDataService
                        .getUserUniversity(universityId: id)
                        .asObservable()
                },
            dependency.userDataService.getUserUniversityID()
                .asObservable()
                .withUnretained(self)
                .delay(.milliseconds(900), scheduler: MainScheduler.instance)
                .flatMap { owner, id in
                    owner.dependency.universityInfoService
                        .getUniversityInfo(id: id)
                        .asObservable()
                }
        )
        .map { mealPlans, userUniversity, universityInfo -> Mutation in
            .setFetchedHaskikData(mealPlans, userUniversity, universityInfo)
        }
        .catch({ error in
            return .just(
                .setRetryAlert(
                    AlertInfo(
                        type: .errorWithRetry,
                        title: "식단 로딩 중 문제가 발생했어요",
                        message: "인터넷 연결을 확인해주세요"
                    )
                )
            )
        })
    }
}
