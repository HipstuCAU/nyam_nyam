//
//  MealPlanCardsViewController.swift
//  NyamNyam
//
//  Created by 박준홍 on 3/27/24.
//

import RIBs
import UIKit
import RxSwift
import RxCocoa

enum MealPlanCardsPresentableAction {
    
}

protocol MealPlanCardsPresentableListener: AnyObject {
    typealias Action = MealPlanCardsPresentableAction
    typealias State = MealPlanCardsPresentableState
    
    func sendAction(_ action: Action)
    
    var state: Observable<State> { get }
    var currentState: State { get }
}

final class MealPlanCardsViewController: UIViewController, MealPlanCardsPresentable, MealPlanCardsViewControllable {

    weak var listener: MealPlanCardsPresentableListener?
    
    private let disposeBag: DisposeBag = .init()
    
    private let actionRelay: PublishRelay<MealPlanCardsPresentableListener.Action> = .init()
    
    override func viewDidLoad() {
        configureUI()
        bindUI()
        bind(listener: listener)
    }
    
    private func bindUI() {
        guard let listener else { return }
        
        listener.state.map(\.dateFilteredMealPlans)
            .compactMap({ $0 })
            .distinctUntilChanged()
            .bind(with: self) { owner, mealPlans in
                
            }
            .disposed(by: disposeBag)
    }
    
    private func bind(listener: MealPlanCardsPresentableListener?) {
        guard let listener else { return }
        self.bindActionRelay(listener: listener)
        self.bindActions()
    }
}

// MARK: - Bind Action Relay
private extension MealPlanCardsViewController {
    func bindActionRelay(listener: MealPlanCardsPresentableListener?) {
        self.actionRelay
            .bind(with: self) { owner, action in
                listener?.sendAction(action)
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - Bind Actions
private extension MealPlanCardsViewController {
    func bindActions() {
        
    }
}

private extension MealPlanCardsViewController {
    func configureUI() {
        
    }
}
