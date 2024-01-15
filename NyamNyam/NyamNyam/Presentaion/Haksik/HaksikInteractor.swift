//
//  HaksikInteractor.swift
//  NyamNyam
//
//  Created by Sdaq on 2024/01/15.
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

final class HaksikInteractor: PresentableInteractor<HaksikPresentable>,
                              HaksikInteractable,
                              HaksikPresentableListener,
                              Reactor {
    typealias Action = HaksikPresentableAction
    
    typealias State = HaksikPresentableState
    
    let initialState: HaksikPresentableState
    
    weak var router: HaksikRouting?
    
    weak var listener: HaksikListener?

    override init(presenter: HaksikPresentable) {
        self.initialState = State()
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func sendAction(_ action: Action) {
        self.action.onNext(action)
    }
}
