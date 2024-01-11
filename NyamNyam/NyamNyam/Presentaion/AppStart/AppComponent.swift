//
//  AppComponent.swift
//  NyamNyam
//
//  Created by Sdaq on 2024/01/08.
//

import RIBs

class AppComponent: Component<EmptyDependency>, RootDependency {
    
    init() {
        super.init(dependency: EmptyComponent())
    }
}
