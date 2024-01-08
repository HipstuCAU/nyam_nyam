//
//  RootBuilder.swift
//  NyamNyam
//
//  Created by Sdaq on 2024/01/08.
//

import RIBs

protocol RootDependency: EmptyDependency {
    
}

final class RootComponent: Component<RootDependency> {
    
    let rootViewController: RootViewController
    
    init(
        dependency: RootDependency,
        rootViewController: RootViewController
    ) {
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }
    
    func build() -> LaunchRouting {
        let viewController = RootViewController()
        
        let component = RootComponent(
            dependency: dependency,
            rootViewController: viewController
        )
        
        let interactor = RootInteractor(presenter: viewController)
        
        return RootRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}