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
    var dateButtons: [DateButton] = []
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = Pallete.skyBlue.color
        initDateButtons()
        setDateButtonsLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initDateButtons() {
        for idx in 0 ..< 7 {
            dateButtons.append(DateButton(
                date:Date().convertDay(for: idx))
            )
        }
    }
}

extension DateSelectView {
    private func setDateButtonsLayout() {
        let count = 7
        var previous: DateButton?
        var width = UIScreen.main.bounds.width
        for idx in 0 ..< count {
            let button = dateButtons[idx]
            self.addSubview(button)
            button.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.width.equalTo(27)
                make.height.equalTo(43)
                if idx == 0 {
                    make.leading.equalToSuperview().offset(20)
                } else {
                    make.leading.equalTo(previous!.snp.leading).offset((width - 67) / 6
                    )
                }
            }
            previous = button
        }
        
    }
}
