//
//  HaksikViewController.swift
//  NyamNyam
//
//  Created by 박준홍 on 2024/01/15.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit

enum HaksikPresentableAction {
    case viewDidLoad
    case retryLoad
}

protocol HaksikPresentableListener: AnyObject {
    typealias Action = HaksikPresentableAction
    typealias State = HaksikPresentableState
    
    func sendAction(_ action: Action)
    
    var state: Observable<State> { get }
    var currentState: State { get }
}

final class HaksikViewController: UIViewController,
                                  HaksikPresentable,
                                  HaksikViewControllable,
                                  NavigationConfigurable {

    weak var listener: HaksikPresentableListener?
    
    private let disposeBag: DisposeBag = .init()
    
    private let actionRelay: PublishRelay<HaksikPresentableListener.Action> = .init()
    
    override func viewDidLoad() {
        view.backgroundColor = Pallete.cauBlue.color
        deactivateNavigation()
        configureUI()
        bindUI()
        bind(listener: listener)
    }
    
    private func bindUI() {
        listener?.state.map(\.isLoading)
            .distinctUntilChanged()
            .bind(onNext: { print($0) })
            .disposed(by: disposeBag)
            
    }
    
    private func bind(listener: HaksikPresentableListener?) {
        guard let listener else { return }
        self.bindActionRelay(listener: listener)
        self.bindActions()
    }
}

// MARK: - Bind Action Relay
private extension HaksikViewController {
    func bindActionRelay(listener: HaksikPresentableListener?) {
        self.actionRelay
            .bind(with: self) { owner, action in
                listener?.sendAction(action)
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - Bind Actions
private extension HaksikViewController {
    func bindActions() {
        self.rx.viewDidLoad
            .map { .viewDidLoad }
            .bind(to: self.actionRelay)
            .disposed(by: disposeBag)
    }
}

private extension HaksikViewController {
    func configureUI() {
        
    }
}
