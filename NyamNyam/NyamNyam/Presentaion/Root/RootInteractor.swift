//
//  RootInteractor.swift
//  NyamNyam
//
//  Created by 박준홍 on 2024/01/08.
//

import RIBs
import ReactorKit
import RxSwift
import RxCocoa

protocol RootRouting: ViewableRouting {
    func attachHaksik(mealPlans: [MealPlan])
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
}

protocol RootInteractorDependency {
    
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
        case setMealPlans([MealPlan])
        case setLoading(Bool)
        case setRetryAlert(AlertInfo)
    }
    
    // MARK: - RootPresentableListener
    func sendAction(_ action: Action) {
        self.action.onNext(action)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case let .setMealPlans(mealPlans):
            router?.attachHaksik(mealPlans: mealPlans)
            
        case let .setRetryAlert(alertInfo):
            state.alertInfo = alertInfo
            
        case let .setLoading(status):
            state.isLoading = status
        }
        
        return state
    }
}
