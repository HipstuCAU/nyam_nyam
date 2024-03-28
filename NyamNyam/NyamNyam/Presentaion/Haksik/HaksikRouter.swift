//
//  HaksikRouter.swift
//  NyamNyam
//
//  Created by 박준홍 on 2024/01/15.
//

import RIBs

protocol HaksikInteractable: Interactable,
                             MealPlanCardsListener {
    var router: HaksikRouting? { get set }
    var listener: HaksikListener? { get set }
}

protocol HaksikViewControllable: ViewControllable {
    func showMealPlanCards(mealPlanCards: ViewControllable)
    func dismissMealPlanCards(mealPlanCards: ViewControllable)
}

final class HaksikRouter: ViewableRouter<HaksikInteractable, HaksikViewControllable>,
                          HaksikRouting {
    
    private var mealPlanCardsRouter: MealPlanCardsRouting?
    
    private let mealPlanCardsBuilder: MealPlanCardsBuildable
    
    init(
        interactor: HaksikInteractable,
        viewController: HaksikViewControllable,
        mealPlanCardsBuilder: MealPlanCardsBuildable
    ) {
        self.mealPlanCardsBuilder = mealPlanCardsBuilder
        super.init(
            interactor: interactor,
            viewController: viewController
        )
        interactor.router = self
    }
    
    func attachMealPlanCards(
        mealPlans: [MealPlan],
        cafeteriasID: [String]
    ) {
        detachMealPlanCards()
        guard mealPlanCardsRouter == nil else { return }
        let router = mealPlanCardsBuilder.build(
            withListener: interactor,
            mealPlans: mealPlans,
            cafeteriasID: cafeteriasID
        )
        attachChild(router)
        viewController.showMealPlanCards(
            mealPlanCards: router.viewControllable
        )
    }
    
    func detachMealPlanCards() {
        if let mealPlanCardsRouter {
            detachChild(mealPlanCardsRouter)
            viewController.dismissMealPlanCards(
                mealPlanCards: mealPlanCardsRouter.viewControllable
            )
        }
    }
}
