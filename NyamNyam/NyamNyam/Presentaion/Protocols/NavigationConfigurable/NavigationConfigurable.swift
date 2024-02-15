//
//  NavigationConfigurable.swift
//  NyamNyam
//
//  Created by 박준홍 on 1/23/24.
//

import UIKit

protocol NavigationConfigurable {
    func activateNavigation()
    func deactivateNavigation()
}

extension NavigationConfigurable where Self: UIViewController {
    func activateNavigation() {
        configureNavigationBar(hidden: false, animated: false)
        configureSwipeBack(enabled: true)
    }
    
    func deactivateNavigation() {
        configureNavigationBar(hidden: true, animated: false)
        configureSwipeBack(enabled: false)
    }
    
    private func configureNavigationBar(hidden: Bool, animated: Bool) {
        navigationController?.setNavigationBarHidden(hidden, animated: animated)
    }

    private func configureSwipeBack(enabled: Bool) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = enabled
    }
}
