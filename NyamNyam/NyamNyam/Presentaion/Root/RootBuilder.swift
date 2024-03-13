//
//  RootBuilder.swift
//  NyamNyam
//
//  Created by 박준홍 on 2024/01/08.
//

import RIBs
import RxCocoa

protocol RootDependency: Dependency {
    
}

final class RootComponent: Component<RootDependency>,
                           RootInteractorDependency,
                           HaksikDependency {
    
    override init(dependency: RootDependency) {
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
