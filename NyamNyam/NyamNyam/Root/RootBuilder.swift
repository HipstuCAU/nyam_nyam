//
//  RootBuilder.swift
//  NyamNyam
//
//  Created by Sdaq on 2024/01/08.
//

import RIBs

protocol RootDependency: EmptyDependency {
    
}

final class RootComponent: Component<RootDependency>,
                           RootInteractorDependency {
    
    let rootViewController: RootViewController
    
    let haksikDataService: HaksikService
    
    init(
        dependency: RootDependency,
        rootViewController: RootViewController,
        repository: MealPlanRepository
    ) {
        self.rootViewController = rootViewController
        self.haksikDataService = HaksikService(
            repository: repository
        )
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>,
                         RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }
    
    func build() -> LaunchRouting {
        let viewController = RootViewController()
        
        let repository = MealPlanRepositoryImpl(
            remoteRepository: MealPlanJsonRemoteRepositoryImpl(),
            localRepository: MealPlanJsonLocalRepositoryImpl()
        )
        
        let component = RootComponent(
            dependency: dependency,
            rootViewController: viewController,
            repository: repository
        )
        
        let interactor = RootInteractor(
            presenter: viewController,
            dependency: component
        )
        
        return RootRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}
