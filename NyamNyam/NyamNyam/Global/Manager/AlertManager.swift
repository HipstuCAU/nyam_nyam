//
//  AlertManager.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/03/18.
//

import UIKit

final class AlertManager {
    
    private init() {}
    
    static func addAlert(_ target: UIViewController, key: String, title: String, message: String, perform: @escaping () -> Void) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(key), object: nil, queue: nil) { [weak target] _ in
            guard let target = target else { return }
            target.modalPresentationStyle = .overFullScreen
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default)
            alert.addAction(action)
            target.present(alert, animated: true)
            perform()
        }
    }
    
    static func performAlertAction(of key: String) {
        NotificationCenter.default.post(name: NSNotification.Name(key), object: nil)

    }
}
