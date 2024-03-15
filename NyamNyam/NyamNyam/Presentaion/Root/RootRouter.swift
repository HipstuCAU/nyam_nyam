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
    func presentFullScreenPage(viewControllable: ViewControllable)
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
    
    func attachHaksik() {
        guard attachedRouter == nil
        else { return }
        
        let haksikRouter = haksikBuilder.build(
            withListener: self.interactor
        )
        self.attachChild(haksikRouter)
        self.attachedRouter = haksikRouter
        
        viewController.presentFullScreenPage(
            viewControllable: haksikRouter.viewControllable
        )
    }
}
