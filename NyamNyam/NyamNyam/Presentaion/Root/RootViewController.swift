//
//  RootViewController.swift
//  NyamNyam
//
//  Created by 박준홍 on 2024/01/08.
//

import UIKit
import RIBs
import RxSwift
import RxCocoa
import SnapKit
import Then

enum RootPresentableAction {
    case viewDidLoad
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
                                RootViewControllable,
                                AlertPresentable {

    weak var listener: RootPresentableListener?
    
    private let disposeBag: DisposeBag = .init()
    
    private let actionRelay: PublishRelay<RootPresentableListener.Action> = .init()
    
    private let loadingIndicator = UIActivityIndicatorView().then {
        $0.style = .medium
        $0.color = .white
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        configureUI()
        bindUI()
        bind(listener: listener)
        actionRelay.accept(.viewDidLoad)
    }
    private func bind(listener: RootPresentableListener?) {
        guard let listener else { return }
        self.bindActionRelay(listener: listener)
        self.bindActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func presentFullScreenPage(viewControllable: ViewControllable) {
        let viewController = viewControllable.uiviewController
        self.addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        viewController.didMove(toParent: self)
    }

}
// MARK: - Bind UI
private extension RootViewController {
    private func bindUI() {
        
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
        view.addSubview(loadingIndicator)
        self.loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }
    }
}
