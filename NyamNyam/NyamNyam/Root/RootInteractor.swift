//
//  RootInteractor.swift
//  NyamNyam
//
//  Created by Sdaq on 2024/01/08.
//

import RIBs
import ReactorKit
import RxSwift

protocol RootRouting: ViewableRouting {
    
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
    
}

protocol RootInteractorDependency {
    var haksikDataService: HaksikService { get }
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
    
    enum Mutation {
        case setLoading(Bool)
    }
    
    init(presenter: RootPresentable, dependency: RootInteractorDependency) {
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
    
    // MARK: - RootPresentableListener
    
    func sendAction(_ action: Action) {
        self.action.onNext(action)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadData:
            return .concat([
                .just(.setLoading(true)),
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setLoading(isLoading):
            newState.isLoading = isLoading
        }
        
        return newState
    }
}
