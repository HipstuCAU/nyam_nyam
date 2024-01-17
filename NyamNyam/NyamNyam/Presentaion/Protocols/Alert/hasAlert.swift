//
//  hasAlert.swift
//  NyamNyam
//
//  Created by Noah Park on 1/17/24.
//

import UIKit

protocol hasAlert where Self: UIViewController {
    func showAlert(alertInfo: AlertInfo, actions: [UIAlertAction])
}

extension hasAlert {
    func showAlert(alertInfo: AlertInfo, actions: [UIAlertAction]) {
        let alert = UIAlertController(
            title: alertInfo.title,
            message: alertInfo.message,
            preferredStyle: .alert
        )
        actions.forEach {
            alert.addAction($0)
        }
        self.present(alert, animated: true)
    }
}
