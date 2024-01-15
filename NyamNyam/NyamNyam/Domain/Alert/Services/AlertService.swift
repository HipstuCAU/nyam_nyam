//
//  AlertService.swift
//  NyamNyam
//
//  Created by Sdaq on 2024/01/15.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol AlertService {
    func showAlert(alertInfo: AlertInfo)
}

final class AlertServiceImpl: AlertService {
    private let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func showAlert(alertInfo: AlertInfo) {
        window?.rootViewController?.present(
            UIAlertController(
                title: alertInfo.title,
                message: alertInfo.message,
                preferredStyle: .alert
            ),
            animated: true
        )
    }
}
