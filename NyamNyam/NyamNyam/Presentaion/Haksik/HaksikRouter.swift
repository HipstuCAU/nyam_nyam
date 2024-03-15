//
//  HaksikRouter.swift
//  NyamNyam
//
//  Created by 박준홍 on 2024/01/15.
//

import RIBs

protocol HaksikInteractable: Interactable {
    var router: HaksikRouting? { get set }
    var listener: HaksikListener? { get set }
}

protocol HaksikViewControllable: ViewControllable {
   
}

final class HaksikRouter: ViewableRouter<HaksikInteractable, HaksikViewControllable>,
                          HaksikRouting {
    
    override init(
        interactor: HaksikInteractable,
        viewController: HaksikViewControllable
    ) {
        super.init(
            interactor: interactor,
            viewController: viewController
        )
        interactor.router = self
    }
}
