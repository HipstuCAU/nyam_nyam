//
//  RootInteractor.swift
//  NyamNyam
//
//  Created by Sdaq on 2024/01/08.
//

import RIBs
import ReactorKit
import RxSwift
import RxCocoa

protocol RootRouting: ViewableRouting {
    
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
}

protocol RootInteractorDependency {
    var haksikService: HaksikService { get }
    var applicationDidBecomeActiveRelay: PublishRelay<Void> { get }
}

protocol RootListener: AnyObject {
    
}

final class RootInteractor: PresentableInteractor<RootPresentable>,
                            RootInteractable,
                            RootPresentableListener,
                            Reactor {
    private let dependency: RootInteractorDependency
    
    typealias Action = RootPresentableAction
    
    typealias State = RootPresentableState
    
    let initialState: RootPresentableState
    
    weak var router: RootRouting?
    
    weak var listener: RootListener?
    
    init(
        presenter: RootPresentable,
        dependency: RootInteractorDependency
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
    
    // MARK: - RootPresentableListener
    func sendAction(_ action: Action) {
        self.action.onNext(action)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .retryLoad:
            return .concat([
                .just(.setLoading(true)),
                self.fetchMealPlanTransform(),
                .just(.setLoading(false))
            ])
        }
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let applicationDidBecomeActive = dependency.applicationDidBecomeActiveRelay
            .withUnretained(self)
            .flatMap { owner, mutation -> Observable<Mutation> in
                return Observable.concat([
                    .just(.setLoading(true)),
                    owner.fetchMealPlanTransform(),
                    .just(.setLoading(false))
                ])
            }

        return .merge(mutation, applicationDidBecomeActive)
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .setMealPlan(mealPlan):
            print(mealPlan)
        case let .setRetryAlert(alertInfo):
            break
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
