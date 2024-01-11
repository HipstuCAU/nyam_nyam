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
                           RootInteractorDependency {
    
    let rootViewController: RootViewController
    
    let applicationDidBecomeActiveRelay: PublishRelay<Void>
    
    let haksikService: HaksikService
    
    init(
        dependency: RootDependency,
        rootViewController: RootViewController
    ) {
        self.rootViewController = rootViewController
        // TODO: repository를 presentation layer에서 주입할 것인지 고민
        self.haksikService = HaksikService()
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
