//
//  SelectedDateStream.swift
//  NyamNyam
//
//  Created by 박준홍 on 3/27/24.
//

import Foundation
import RxSwift
import RxCocoa

protocol SelectedDateStream: AnyObject {
    var selectedDate: Observable<Date?> { get }
}

protocol MutableSelectedDateStream: SelectedDateStream {
    func updateDate(with: Date?)
}

final class SelectedDateStreamImpl: MutableSelectedDateStream {
    
    private let variable = BehaviorRelay<Date?>(value: nil)
    
    var selectedDate: Observable<Date?> {
        variable.distinctUntilChanged()
    }
    
    func updateDate(with newDate: Date?) {
        variable.accept(newDate)
    }
}
