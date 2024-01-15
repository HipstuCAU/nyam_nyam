//
//  RootBuilder.swift
//  NyamNyam
//
//  Created by Sdaq on 2024/01/08.
//

import RIBs
import RxCocoa

protocol RootDependency: Dependency {
    var applicationDidBecomeActiveRelay: PublishRelay<Void> { get }
}

final class RootComponent: Component<RootDependency>,
                           RootInteractorDependency,
                           HaksikDependency {
    
    let rootViewController: RootViewController
    
    let applicationDidBecomeActiveRelay: PublishRelay<Void>
    
    let haksikService: HaksikService
    
    init(
        dependency: RootDependency,
        rootViewController: RootViewController
    ) {
        self.rootViewController = rootViewController
        
        let remoteRepository = MockMealPlanJsonRemoteRepositoryImpl()
        let localRepository = MealPlanJsonLocalRepositoryImpl()
        
        self.haksikService = HaksikService(
            repository: MealPlanRepositoryImpl(
                remoteRepository: remoteRepository,
                localRepository: localRepository
            )
        )
        self.applicationDidBecomeActiveRelay = dependency.applicationDidBecomeActiveRelay
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
        
        let component = RootComponent(
            dependency: dependency,
            rootViewController: viewController
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
