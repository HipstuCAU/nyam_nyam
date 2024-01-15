//
//  HaksikBuilder.swift
//  NyamNyam
//
//  Created by Sdaq on 2024/01/15.
//

import RIBs

protocol HaksikDependency: Dependency {
    var haksikService: HaksikService { get }
}

final class HaksikComponent: Component<HaksikDependency> {
    let haksikService: HaksikService
    
    override init(dependency: HaksikDependency) {
        self.haksikService = dependency.haksikService
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol HaksikBuildable: Buildable {
    func build(withListener listener: HaksikListener) -> HaksikRouting
}

final class HaksikBuilder: Builder<HaksikDependency>,
                           HaksikBuildable {

    override init(dependency: HaksikDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: HaksikListener) -> HaksikRouting {
        let component = HaksikComponent(dependency: dependency)
        let viewController = HaksikViewController()
        let interactor = HaksikInteractor(presenter: viewController)
        interactor.listener = listener
        return HaksikRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}
