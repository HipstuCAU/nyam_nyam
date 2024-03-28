//
//  MealPlanCardsBuilder.swift
//  NyamNyam
//
//  Created by 박준홍 on 3/27/24.
//

import RIBs

protocol MealPlanCardsDependency: Dependency {
    var selectedCafeteriaIDStream: SelectedCafeteriaIDStream { get }
    var selectedDateStream: SelectedDateStream { get }
}

final class MealPlanCardsComponent: Component<MealPlanCardsDependency>,
                                    MealPlanCardsInteractorDependency {
    let selectedCafeteriaIDStream: SelectedCafeteriaIDStream
    let selectedDateStream: SelectedDateStream
    let mealPlans: [MealPlan]
    let cafeteriasID: [String]
    
    init(
        dependency: MealPlanCardsDependency,
        mealPlans: [MealPlan],
        cafeteriasID: [String]
    ) {
        self.selectedCafeteriaIDStream = dependency.selectedCafeteriaIDStream
        self.selectedDateStream = dependency.selectedDateStream
        self.mealPlans = mealPlans
        self.cafeteriasID = cafeteriasID
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol MealPlanCardsBuildable: Buildable {
    func build(
        withListener listener: MealPlanCardsListener,
        mealPlans: [MealPlan],
        cafeteriasID: [String]
    ) -> MealPlanCardsRouting
}

final class MealPlanCardsBuilder: Builder<MealPlanCardsDependency>,
                                  MealPlanCardsBuildable {

    override init(dependency: MealPlanCardsDependency) {
        super.init(dependency: dependency)
    }

    func build(
        withListener listener: MealPlanCardsListener,
        mealPlans: [MealPlan],
        cafeteriasID: [String]
    ) -> MealPlanCardsRouting {
        let component = MealPlanCardsComponent(
            dependency: dependency,
            mealPlans: mealPlans,
            cafeteriasID: cafeteriasID
        )
        let viewController = MealPlanCardsViewController()
        let interactor = MealPlanCardsInteractor(
            presenter: viewController,
            dependency: component
        )
        interactor.listener = listener
        return MealPlanCardsRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}
