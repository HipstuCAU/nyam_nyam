//
//  DayPickerButton.swift
//  NyamNyam
//
//  Created by 박준홍 on 3/18/24.
//

import UIKit
import SnapKit

final class DayPickerButton: UIButton {
    
    let date: Date
    
    let isAvailable: Bool
    
    var selectStatus: Bool = false {
        didSet {
            if isAvailable {
                dayLabel.textColor =  selectStatus ?
                    .white : Pallete.textBlack.color
                weekDayLabel.textColor =  selectStatus ?
                    .white : Pallete.textBlack.color
            } else {
                dayLabel.textColor = Pallete.invalidButtonText.color
                weekDayLabel.textColor = Pallete.invalidButtonText.color
            }
        }
    }
    
    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.font = Pretendard.semiBold.size(15)
        label.text = self.date.extractDay()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var weekDayLabel: UILabel = {
        let label = UILabel()
        label.font = Pretendard.semiBold.size(15)
        label.text = self.date.extractWeekday()
        label.textAlignment = .center
        return label
    }()
    
    init(
        frame: CGRect,
        date: Date,
        isAvailable: Bool
    ) {
        self.date = date
        self.isAvailable = isAvailable
        super.init(frame: frame)
        setButtonLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButtonLayout() {
        self.addSubview(dayLabel)
        self.addSubview(weekDayLabel)
        
        dayLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.snp.centerY)
        }
        
        weekDayLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.snp.centerY)
        }
    }
}
