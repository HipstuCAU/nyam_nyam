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
    var mealPlans: [MealPlan] { get }
    var haksikService: HaksikService { get }
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
        case setMealPlan(MealPlan)
        case setLoading(Bool)
        case setRetryAlert(AlertInfo)
    }
    
    func sendAction(_ action: Action) {
        self.action.onNext(action)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return .empty()
        case .retryLoad:
            return .concat([
                .just(.setLoading(true)),
                self.fetchMealPlanTransform(),
                .just(.setLoading(false))
            ])
        }
    }
    
//    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
//        let applicationDidBecomeActive = dependency.applicationDidBecomeActiveRelay
//            .withUnretained(self)
//            .flatMap { owner, mutation -> Observable<Mutation> in
//                return Observable.concat([
//                    .just(.setLoading(true)),
//                    owner.fetchMealPlanTransform(),
//                    .just(.setLoading(false))
//                ])
//            }
//
//        return .merge(mutation, applicationDidBecomeActive)
//    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .setMealPlan(mealPlan):
            // TODO: Data를 통해 그리기
            break
            
        case let .setRetryAlert(alertInfo):
            state.alertInfo = alertInfo
            
        case let .setLoading(status):
            state.isLoading = status
        }
        
        return state
    }
    
    private func fetchMealPlanTransform() -> Observable<Mutation> {
        self.dependency.haksikService.fetchMealPlan()
            .asObservable()
            .map { mealPlan -> Mutation in
                .setMealPlan(mealPlan)
            }
            .catchAndReturn(
                .setRetryAlert(
                    AlertInfo(
                        type: .errorWithRetry,
                        title: "식단 로딩 중 문제가 발생했어요",
                        message: "인터넷 연결을 확인해주세요"
                    )
                )
            )
    }
}
