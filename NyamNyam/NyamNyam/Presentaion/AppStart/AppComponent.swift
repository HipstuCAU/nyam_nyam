//
//  AppComponent.swift
//  NyamNyam
//
//  Created by Sdaq on 2024/01/08.
//

import RIBs
import RxCocoa

final class AppComponent: Component<EmptyDependency>,
                          RootDependency {
    let alertService: AlertService
    
    let applicationDidBecomeActiveRelay: PublishRelay<Void> = .init()
    
    
    init(alertService: AlertService) {
        self.alertService = alertService
        super.init(dependency: EmptyComponent())
    }
}
