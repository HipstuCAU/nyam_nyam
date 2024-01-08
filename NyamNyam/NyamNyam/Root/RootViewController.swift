//
//  RootViewController.swift
//  NyamNyam
//
//  Created by Sdaq on 2024/01/08.
//

import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: AnyObject {
   
}

final class RootViewController: UIViewController,
                                RootPresentable,
                                RootViewControllable {

    weak var listener: RootPresentableListener?
    
    override func viewDidLoad() {
        
    }
    
    // MARK: - Private
    
    
}
