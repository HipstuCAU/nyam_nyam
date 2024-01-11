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
import Then

enum RootPresentableAction {
    case retryLoad
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
    
    private let disposeBag: DisposeBag = .init()
    
    private let actionRelay: PublishRelay<RootPresentableListener.Action> = .init()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        configureUI()
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
}

// MARK: - Bind UI
private extension RootViewController {
    func bindLoadingIndicator() {
        listener?.state.map(\.isLoading)
            .bind(with: self, onNext: { owner, isLoading in
                print(isLoading)
            })
            .disposed(by: disposeBag)
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
        
    }
}

private extension RootViewController {
    func configureUI() {
        view.backgroundColor = Pallete.cauBlue.color
    }
}
