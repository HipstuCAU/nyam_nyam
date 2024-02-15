//
//  RIBs+.swift
//  NyamNyam
//
//  Created by 박준홍 on 1/22/24.
//

import Foundation
import RIBs
import UIKit

public extension ViewControllable {
    
    func present(_ viewControllable: ViewControllable, animated: Bool, completion: (() -> Void)?) {
        self.uiviewController.present(
            viewControllable.uiviewController,
            animated: animated,
            completion: completion
        )
    }
    
    func dismiss(completion: (() -> Void)?) {
        self.uiviewController.dismiss(
            animated: true,
            completion: completion
        )
    }
    
    func pushViewController(_ viewControllable: ViewControllable, animated: Bool) {
        if let nav = self.uiviewController as? UINavigationController {
            nav.pushViewController(
                viewControllable.uiviewController,
                animated: animated
            )
        } else {
            self.uiviewController.navigationController?.pushViewController(
                viewControllable.uiviewController,
                animated: animated
            )
        }
    }
    
    func popViewController(animated: Bool) {
        if let nav = self.uiviewController as? UINavigationController {
            nav.popViewController(animated: animated)
        } else {
            self.uiviewController.navigationController?.popViewController(animated: animated)
        }
    }
    
    func popToRoot(animated: Bool) {
        if let nav = self.uiviewController as? UINavigationController {
            nav.popToRootViewController(animated: animated)
        } else {
            self.uiviewController.navigationController?.popToRootViewController(animated: animated)
        }
    }
    
    func setViewControllers(_ viewControllerables: [ViewControllable]) {
        if let nav = self.uiviewController as? UINavigationController {
            nav.setViewControllers(
                viewControllerables.map(\.uiviewController),
                animated: true
            )
        } else {
            self.uiviewController.navigationController?.setViewControllers(
                viewControllerables.map(\.uiviewController),
                animated: true
            )
        }
    }
    
    var topViewControllable: ViewControllable {
        var top: ViewControllable = self
        
        while let presented = top.uiviewController.presentedViewController as? ViewControllable {
            top = presented
        }
        
        return top
    }
}
