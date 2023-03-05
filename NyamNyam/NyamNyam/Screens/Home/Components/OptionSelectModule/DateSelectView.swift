//
//  DateSelectView.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/03/05.
//

import UIKit

protocol DateSelectViewDelegate: AnyObject {
    
}

final class DateSelectView: UIView {
    weak var delegate: DateSelectViewDelegate?
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = Pallete.skyBlue.color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
