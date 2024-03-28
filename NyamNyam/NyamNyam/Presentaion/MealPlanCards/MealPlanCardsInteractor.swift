//
//  MealPlanCardsInteractor.swift
//  NyamNyam
//
//  Created by 박준홍 on 3/27/24.
//

import RIBs
import ReactorKit
import RxSwift
import RxCocoa

protocol MealPlanCardsRouting: ViewableRouting {
  
}

protocol MealPlanCardsPresentable: Presentable {
    var listener: MealPlanCardsPresentableListener? { get set }
    
}

protocol MealPlanCardsListener: AnyObject {
    
}

protocol MealPlanCardsInteractorDependency {
    var mealPlans: [MealPlan] { get }
    var cafeteriasID: [String] { get }
    var selectedCafeteriaIDStream: SelectedCafeteriaIDStream { get }
    var selectedDateStream: SelectedDateStream { get }
}

final class MealPlanCardsInteractor: PresentableInteractor<MealPlanCardsPresentable>,
                                     MealPlanCardsInteractable,
                                     MealPlanCardsPresentableListener,
                                     Reactor {
    
    private let dependency: MealPlanCardsInteractorDependency
    
    typealias Action = MealPlanCardsPresentableAction
    
    typealias State = MealPlanCardsPresentableState
    
    let initialState: MealPlanCardsPresentableState
    
    weak var router: MealPlanCardsRouting?
    
    weak var listener: MealPlanCardsListener?

    init(
        presenter: MealPlanCardsPresentable,
        dependency: MealPlanCardsInteractorDependency
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
        case setDateFilteredMealPlans([MealPlan])
    }
    
    func sendAction(_ action: Action) {
        self.action.onNext(action)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let dateFilteredMealPlans = dependency.selectedDateStream
            .selectedDate
            .withUnretained(self)
            .map { owner, date -> Mutation in
                return .setDateFilteredMealPlans(
                    owner.dependency.mealPlans
                        .filter { $0.date == date }
                )
            }
        
        let didSelectCafeteria = dependency.selectedCafeteriaIDStream
        
        return .merge([mutation, dateFilteredMealPlans])
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .setDateFilteredMealPlans(mealPlans):
            state.dateFilteredMealPlans = mealPlans
        }
        
        return state
    }
}
