//
//  DatePickerView.swift
//  NyamNyam
//
//  Created by 박준홍 on 3/16/24.
//

import UIKit
import SnapKit

final class DatePickerView: UIView {
    
    private var dayButtons: [DayPickerButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDatePickerButtons(startDate: Date, for days: Int) {
        dismissDatePickerButtons()
        
        guard days > 0 else { return }
        
        let buttonWidth: CGFloat = 30.0
        let totalWidth: CGFloat = self.bounds.width
        let totalSpace = totalWidth - (buttonWidth * CGFloat(days))
        let spaceBlock = totalSpace / CGFloat(4 + ((days - 1) * 3))
        
        let screenToButtonSpace: CGFloat = spaceBlock * 2
        
        let buttonToButtonSpace: CGFloat
        if days > 1 {
            buttonToButtonSpace = spaceBlock * 3
        } else {
            buttonToButtonSpace = 0
        }
        
        for day in 0..<days {
            let addedDate = startDate.adding(days: day)
            let dayPickerButton = DayPickerButton(
                frame: .zero,
                date: addedDate
            )
            dayButtons.append(dayPickerButton)
        }
        
        var previousButton: DayPickerButton? = nil
        
        for dayButton in dayButtons {
            self.addSubview(dayButton)
            dayButton.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(8)
                make.bottom.equalToSuperview().offset(-13)
                if let previousButton {
                    make.leading.equalTo(previousButton.snp.trailing).offset(buttonToButtonSpace)
                } else {
                    make.leading.equalToSuperview().offset(screenToButtonSpace)
                }
            }
            previousButton = dayButton
        }
    }
    
    func dismissDatePickerButtons() {
        for dayButton in dayButtons {
            dayButton.removeFromSuperview()
        }
        dayButtons.removeAll()
    }
}

final class DayPickerButton: UIButton {
    
    private let date: Date
    
    private var selectStatus: Bool = false {
        didSet {
            dayLabel.textColor =  selectStatus ?
                .white : Pallete.invalidButtonText.color
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
        date: Date
    ) {
        self.date = date
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
