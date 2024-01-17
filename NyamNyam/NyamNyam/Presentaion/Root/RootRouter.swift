//
//  RootRouter.swift
//  NyamNyam
//
//  Created by Sdaq on 2024/01/08.
//

import RIBs

protocol RootInteractable: Interactable {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>,
                        RootRouting {

    override init(
        interactor: RootInteractable,
        viewController: RootViewControllable
    ) {
        super.init(
            interactor: interactor,
            viewController: viewController
        )
        interactor.router = self
    }
}
