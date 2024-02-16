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
import Then

enum RootPresentableAction {
    
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
    }
    
    private func bindUI() {
        
    }
    
    private func bind(listener: RootPresentableListener?) {
        guard let listener else { return }
        self.bindActionRelay(listener: listener)
        self.bindActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func presentFullScreen(_ viewControllable: ViewControllable) {
        let viewController = viewControllable.uiviewController
        let navigationController = UINavigationController(
            rootViewController: viewController
        )
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: false, completion: nil)
    }
}
// MARK: - Bind UI
private extension RootViewController {
//    func bindLoadingIndicator() {
//        listener?.state.map(\.isLoading)
//            .distinctUntilChanged()
//            .bind(to: self.loadingIndicator.rx.isAnimating)
//            .disposed(by: disposeBag)
//    }
    
//    func bindAlert() {
//        listener?.state.map(\.alertInfo)
//            .compactMap({ $0 })
//            .distinctUntilChanged()
//            .observe(on: MainScheduler.instance)
//            .bind(with: self, onNext: { owner, alertInfo in
//                owner.showAlertOnWindow(
//                    alertInfo: alertInfo,
//                    actions: [UIAlertAction(
//                        title: "재시도",
//                        style: .default
//                    ) { [weak self] _ in
//                        self?.actionRelay.accept(.retryLoad)
//                    }]
//                )
//            })
//            .disposed(by: disposeBag)
//            
//    }
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
