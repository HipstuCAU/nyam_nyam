//
//  HaksikInteractor.swift
//  NyamNyam
//
//  Created by 박준홍 on 2024/01/15.
//

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
        case setMealPlan([MealPlan])
        case setUserUniversityData(UserUniversity)
        case setUniversityInfo(UniversityInfo)
        case setLoading(Bool)
        case setRetryAlert(AlertInfo)
    }
    
    func sendAction(_ action: Action) {
        self.action.onNext(action)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            
        case .viewDidAppear, .retryLoad, .appWillEnterForeground:
            return .concat([
                .just(.setLoading(true)),
                .merge([
                    self.fetchUserUniversityTransform(),
                    self.fetchUniversityInfoTransform(),
                    self.fetchMealPlanTransform()
                ]),
                .just(.setLoading(false)),
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
            
        case let .setMealPlan(mealPlans):
            state.mealPlans = mealPlans
            
        case let .setUserUniversityData(userUniversityData):
            state.userUniversityData = userUniversityData
            
        case let .setUniversityInfo(universityInfo):
            state.universityInfo = universityInfo
            
        case let .setRetryAlert(alertInfo):
            state.alertInfo = alertInfo
            
        case let .setLoading(status):
            state.isLoading = status
        }
        
        return state
    }
    
    private func fetchMealPlanTransform() -> Observable<Mutation> {
        self.dependency.haksikService.fetchMealPlans()
            .asObservable()
            .map { mealPlans -> Mutation in
                .setMealPlan(mealPlans)
            }
            .catch({ error in
                print(error)
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
    
    private func fetchUserUniversityTransform() -> Observable<Mutation> {
        dependency.userDataService.getUserUniversityID()
            .asObservable()
            .withUnretained(self)
            .delay(.milliseconds(300), scheduler: MainScheduler.instance)
            .flatMap { owner, id in
                owner.dependency.userDataService
                    .getUserUniversity(universityId: id)
                    .asObservable()
            }
            .map { userUniversity in
                .setUserUniversityData(userUniversity)
            }
            .catch({ error in
                print(error)
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
    
    private func fetchUniversityInfoTransform() -> Observable<Mutation> {
        dependency.userDataService.getUserUniversityID()
            .asObservable()
            .withUnretained(self)
            .delay(.milliseconds(300), scheduler: MainScheduler.instance)
            .flatMap { owner, id in
                owner.dependency.universityInfoService
                    .getUniversityInfo(id: id)
                    .asObservable()
            }
            .map { universityInfo in
                .setUniversityInfo(universityInfo)
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
