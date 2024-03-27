//
//  SelectedCafeteriaID.swift
//  NyamNyam
//
//  Created by 박준홍 on 3/27/24.
//

import RxSwift
import RxCocoa

protocol SelectedCafeteriaIDStream: AnyObject {
    var selectedID: Observable<String?> { get }
}

protocol MutableSelectedCafeteriaIDStream: SelectedCafeteriaIDStream {
    func updateID(with: String?)
}

final class SelectedCafeteriaIDStreamImpl: MutableSelectedCafeteriaIDStream {
    
    private let variable = BehaviorRelay<String?>(value: nil)
    
    var selectedID: Observable<String?> {
        variable.distinctUntilChanged()
    }
    
    func updateID(with newID: String?) {
        variable.accept(newID)
    }
}

