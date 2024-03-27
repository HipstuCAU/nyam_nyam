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
    var selectedCafeteriaIDStream: MutableSelectedCafeteriaIDStream { get }
    var selectedDateStream: MutableSelectedDateStream { get }
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
    }
    
    func sendAction(_ action: Action) {
        self.action.onNext(action)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        case .viewDidAppear, .retryLoad, .appWillEnterForeground:
            return .concat([
                .just(.setLoading(true)),
                self.fetchHaksikDataTransform(),
                .just(.setLoading(false)),
            ])
            
        case let .dateSelected(date):
            dependency.selectedDateStream.updateDate(with: date)
            return .empty()
            
        case let .cafeteriaSelected(id):
            dependency.selectedCafeteriaIDStream.updateID(with: id)
            return .empty()
        }
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let didSelectCafeteria = dependency.selectedCafeteriaIDStream
            .selectedID
            .map { id -> Mutation in
                .setSelectedCafeteria(id)
            }
        
        let didSelectDate = dependency.selectedDateStream
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
            
            state.mealPlans = mealPlans
            state.userUniversityData = userData
            state.universityInfo = universityInfo
            state.campusTitle = currentCampus?.name
            state.cafeteriaInfos = currentCampus?.cafeteriaInfos ?? []
            state.availableDates = mealPlans
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
                .delay(.milliseconds(300), scheduler: MainScheduler.instance)
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
