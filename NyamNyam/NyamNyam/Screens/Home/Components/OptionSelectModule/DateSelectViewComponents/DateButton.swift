//
//  DateBaseButton.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/03/05.
//

import UIKit

final class DateButton: UIButton {
    
    let dayLabel = UILabel()
    let dayOfWeekLable = UILabel()
    
    init(date: Date) {
        super.init(frame: .zero)
        self.backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
