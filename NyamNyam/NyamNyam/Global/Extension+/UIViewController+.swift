//
//  UIViewController+.swift
//  NyamNyam
//
//  Created by 박준홍 on 1/22/24.
//

import UIKit

extension UIViewController {
    var activateViewContoller: UIViewController? {
        var topController: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
        while let presentedViewController = topController?.presentedViewController {
            topController = presentedViewController
        }
        return topController
    }
}

