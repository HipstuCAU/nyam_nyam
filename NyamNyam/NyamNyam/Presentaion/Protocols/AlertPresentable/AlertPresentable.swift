//
//  hasAlert.swift
//  NyamNyam
//
//  Created by Noah Park on 1/17/24.
//

import UIKit

protocol AlertPresentable where Self: UIViewController {
    func showAlertOnWindow(alertInfo: AlertInfo, actions: [UIAlertAction])
}

extension AlertPresentable {
    func showAlertOnWindow(alertInfo: AlertInfo, actions: [UIAlertAction]) {
        let alert = UIAlertController(
            title: alertInfo.title,
            message: alertInfo.message,
            preferredStyle: .alert
        )
        actions.forEach {
            alert.addAction($0)
        }
        self.activateViewContoller?.present(alert, animated: true)
    }
}
