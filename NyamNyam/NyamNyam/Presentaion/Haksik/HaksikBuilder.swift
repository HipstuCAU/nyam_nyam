//
//  HaksikBuilder.swift
//  NyamNyam
//
//  Created by 박준홍 on 2024/01/15.
//

import RIBs

protocol HaksikDependency: Dependency {
    
}

final class HaksikComponent: Component<HaksikDependency>,
                             HaksikInteractorDependency {
    let haksikService: HaksikService
    
    init(
        dependency: HaksikDependency,
        mealPlans: [MealPlan]
    ) {
        let localFileName = "CAUMeals"
        
        let remoteCollectionName = "CAU_Haksik"
        
        let remoteDocumentName: String
        #if DEBUG
        remoteDocumentName = "Test_Doc"
        #else
        remoteDocumentName = "CAU_Cafeteria_Menu"
        #endif
        
        haksikService = HaksikServiceImpl(
            repository: MealPlanCompositeRepositoryImpl(
                remoteRepository: MealPlanJsonRemoteRepositoryImpl(
                    collection: remoteCollectionName,
                    document: remoteDocumentName
                ),
                localRepository: MealPlanJsonLocalRepositoryImpl(
                    localFileName: localFileName
                )
            )
        )
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol HaksikBuildable: Buildable {
    func build(withListener listener: HaksikListener, mealPlans: [MealPlan]) -> HaksikRouting
}

final class HaksikBuilder: Builder<HaksikDependency>,
                           HaksikBuildable {

    override init(dependency: HaksikDependency) {
        super.init(dependency: dependency)
    }

    func build(
        withListener listener: HaksikListener,
        mealPlans: [MealPlan]
    ) -> HaksikRouting {
        
        let component = HaksikComponent(
            dependency: dependency,
            mealPlans: mealPlans
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
