//
//  RootBuilder.swift
//  NyamNyam
//
//  Created by 박준홍 on 2024/01/08.
//

import RIBs
import RxCocoa

protocol RootDependency: Dependency {
    var applicationDidBecomeActiveRelay: PublishRelay<Void> { get }
}

final class RootComponent: Component<RootDependency>,
                           RootInteractorDependency,
                           HaksikDependency {
    
    let applicationDidBecomeActiveRelay: PublishRelay<Void>
    
    let haksikService: HaksikService
    
    override init(dependency: RootDependency) {
        
        let remoteRepository = MockMealPlanJsonRemoteRepositoryImpl()
        let localRepository = MealPlanJsonLocalRepositoryImpl()
        
        self.haksikService = HaksikServiceImpl(
            repository: MealPlanCompositeRepositoryImpl(
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
            dependency: dependency
        )
        
        let interactor = RootInteractor(
            presenter: viewController,
            dependency: component
        )
        
        let haksikBuilder = HaksikBuilder(
            dependency: component
        )
        
        return RootRouter(
            interactor: interactor,
            viewController: viewController,
            haksikBuilder: haksikBuilder
        )
    }
}
