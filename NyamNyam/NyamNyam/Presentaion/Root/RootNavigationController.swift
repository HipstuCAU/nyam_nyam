//
//  RootNavigation.swift
//  NyamNyam
//
//  Created by 박준홍 on 1/22/24.
//

import RIBs
import UIKit

public final class RootNavigationControllerable: RootViewControllable, RootPresentable {
    var listener: RootPresentableListener?
    
    public var uiviewController: UIViewController {
        self.navigationController
    }
    
    public let navigationController: UINavigationController
    
    public init(root: ViewControllable) {
        let navigation = UINavigationController(
            rootViewController: root.uiviewController
        )
        
        self.navigationController = navigation
    }
}

