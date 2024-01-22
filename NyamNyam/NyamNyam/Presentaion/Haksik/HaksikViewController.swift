//
//  HaksikViewController.swift
//  NyamNyam
//
//  Created by 박준홍 on 2024/01/15.
//

import RIBs
import RxSwift
import UIKit

enum HaksikPresentableAction {
    
}

protocol HaksikPresentableListener: AnyObject {
    typealias Action = HaksikPresentableAction
    typealias State = HaksikPresentableState
    
    func sendAction(_ action: Action)
    
    var state: Observable<State> { get }
    var currentState: State { get }
}

final class HaksikViewController: UIViewController,
                                  HaksikPresentable,
                                  HaksikViewControllable {

    weak var listener: HaksikPresentableListener?
    
    override func viewDidLoad() {
        view.backgroundColor = .brown
    }
}
