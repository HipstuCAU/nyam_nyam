//
//  MealPlanCardsRouter.swift
//  NyamNyam
//
//  Created by 박준홍 on 3/27/24.
//

import RIBs

protocol MealPlanCardsInteractable: Interactable {
    var router: MealPlanCardsRouting? { get set }
    var listener: MealPlanCardsListener? { get set }
}

protocol MealPlanCardsViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class MealPlanCardsRouter: ViewableRouter<MealPlanCardsInteractable, MealPlanCardsViewControllable>, MealPlanCardsRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: MealPlanCardsInteractable, viewController: MealPlanCardsViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
