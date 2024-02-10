//
//  RootRouter.swift
//  NyamNyam
//
//  Created by 박준홍 on 2024/01/08.
//

import RIBs

protocol RootInteractable: Interactable,
                           HaksikListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func presentFullScreen(_: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>,
                        RootRouting {
    
    private let haksikBuilder: HaksikBuildable
    
    private var attachedRouter: HaksikRouting?

    init(
        interactor: RootInteractable,
        viewController: RootViewControllable,
        haksikBuilder: HaksikBuildable
    ) {
        self.haksikBuilder = haksikBuilder
        super.init(
            interactor: interactor,
            viewController: viewController
        )
        interactor.router = self
    }
    
    func attachHaksik(mealPlan: MealPlan) {
        guard attachedRouter == nil
        else { return }
        
        detachHaksik()
        
        let haksikRouter = haksikBuilder.build(
            withListener: self.interactor,
            mealPlan: mealPlan
        )
        self.attachChild(haksikRouter)
        self.attachedRouter = haksikRouter
        
        self.viewController.presentFullScreen(
            haksikRouter.viewControllable
        )
    }
    
    func detachHaksik() {
        guard let attachedRouter
        else { return }
        
        self.viewControllable.popToRoot(animated: false)
        
        self.detachChild(attachedRouter)
        self.attachedRouter = nil
    }
}
