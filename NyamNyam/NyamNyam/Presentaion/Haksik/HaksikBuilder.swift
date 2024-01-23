//
//  HaksikBuilder.swift
//  NyamNyam
//
//  Created by 박준홍 on 2024/01/15.
//

import RIBs

protocol HaksikDependency: Dependency {
    var haksikService: HaksikService { get }
}

final class HaksikComponent: Component<HaksikDependency>,
                             HaksikInteractorDependency {
    var mealPlan: MealPlan
    
    let haksikService: HaksikService
    
    init(
        dependency: HaksikDependency,
        mealPlan: MealPlan
    ) {
        self.haksikService = dependency.haksikService
        self.mealPlan = mealPlan
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol HaksikBuildable: Buildable {
    func build(withListener listener: HaksikListener, mealPlan: MealPlan) -> HaksikRouting
}

final class HaksikBuilder: Builder<HaksikDependency>,
                           HaksikBuildable {

    override init(dependency: HaksikDependency) {
        super.init(dependency: dependency)
    }

    func build(
        withListener listener: HaksikListener,
        mealPlan: MealPlan
    ) -> HaksikRouting {
        
        let component = HaksikComponent(
            dependency: dependency,
            mealPlan: mealPlan
        )
        let viewController = HaksikViewController()
        let interactor = HaksikInteractor(
            presenter: viewController,
            dependency: component
        )
        interactor.listener = listener
        
        return HaksikRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}
