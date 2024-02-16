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
    
    func attachHaksik(mealPlans: [MealPlan]) {
        guard attachedRouter == nil
        else { return }
        
        let haksikRouter = haksikBuilder.build(
            withListener: self.interactor,
            mealPlans: mealPlans
        )
        self.attachChild(haksikRouter)
        self.attachedRouter = haksikRouter
        
        //TODO: - 추후 변경되어야하는 부분, 테스트를 위해서 .present 를 사용했습니다.
        self.viewControllable.present(haksikRouter.viewControllable, animated: false, completion: {
            
            
        })
    }
}
