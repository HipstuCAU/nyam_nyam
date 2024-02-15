//
//  AppComponent.swift
//  NyamNyam
//
//  Created by 박준홍 on 2024/01/08.
//

import RIBs
import RxCocoa

final class AppComponent: Component<EmptyDependency>,
                          RootDependency {
    let applicationDidBecomeActiveRelay: PublishRelay<Void> = .init()
    
    init() {
        super.init(dependency: EmptyComponent())
    }
}
