//
//  RootViewController.swift
//  NyamNyam
//
//  Created by Sdaq on 2024/01/08.
//

import UIKit
import RIBs
import RxSwift
import RxCocoa

enum RootPresentableAction {
    case loadData
}

protocol RootPresentableListener: AnyObject {
    typealias Action = RootPresentableAction
    typealias State = RootPresentableState
    
    func sendAction(_ action: Action)
    
    var state: Observable<State> { get }
    var currentState: State { get }
}

final class RootViewController: UIViewController,
                                RootPresentable,
                                RootViewControllable {

    weak var listener: RootPresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        bindUI()
        bind(listener: listener)
    }
    
    private func bindUI() {
        bindLoadingIndicator()
    }
    
    private func bind(listener: RootPresentableListener?) {
        guard let listener else { return }
        self.bindActionRelay(listener: listener)
        self.bindActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    private let actionRelay: PublishRelay<RootPresentableListener.Action> = .init()
    
    private let disposeBag: DisposeBag = .init()
}

// MARK: - Bind UI
private extension RootViewController {
    func bindLoadingIndicator() {
        
    }
}

// MARK: - Bind Action Relay
private extension RootViewController {
    func bindActionRelay(listener: RootPresentableListener?) {
        self.actionRelay
            .bind(with: self) { owner, action in
                listener?.sendAction(action)
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - Bind Actions
private extension RootViewController {
    func bindActions() {
        bindViewDidLoadAction()
    }
    
    func bindViewDidLoadAction() {
        rx.viewDidLoad
            .map { .loadData }
            .bind(to: actionRelay)
            .disposed(by: disposeBag)
    }
}
