//
//  AlertService.swift
//  NyamNyam
//
//  Created by Sdaq on 2024/01/15.
//

import UIKit

protocol AlertService {
    func showAlert(
        with id: String,
        title: String,
        message: String,
        actions: [UIAlertAction],
        on viewController: UIViewController
    )
    
    func dismissAlert()
    
    func replaceAlert(
        with id: String,
        title: String,
        message: String,
        actions: [UIAlertAction],
        on viewController: UIViewController
    )
}

final class AlertServiceImpl: AlertService {
    private var alert: UIAlertController?
    
    func showAlert(
        with id: String,
        title: String,
        message: String,
        actions: [UIAlertAction],
        on viewController: UIViewController
    ) {
        guard alert == nil
        else { return }
        
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        actions.forEach { alert.addAction($0) }
        DispatchQueue.main.async {
            viewController.present(alert, animated: true)
        }
        self.alert = alert
    }
    
    func dismissAlert() {
        DispatchQueue.main.async { [weak self] in
            self?.alert?.dismiss(animated: true)
        }
    }
    
    func replaceAlert(
        with id: String,
        title: String,
        message: String,
        actions: [UIAlertAction],
        on viewController: UIViewController
    ) {
        dismissAlert()
        showAlert(
            with: id,
            title: title,
            message: message,
            actions: actions,
            on: viewController
        )
    }
}
