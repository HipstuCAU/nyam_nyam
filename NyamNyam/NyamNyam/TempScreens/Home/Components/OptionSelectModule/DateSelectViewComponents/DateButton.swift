//
//  DateBaseButton.swift
//  NyamNyam
//
//  Created by 박준홍 on 2023/03/05.
//

import UIKit

final class DateButton: UIButton {
    public var buttonIndex: Int
    public var isValid: Bool
    
    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-SemiBold", size: 14)
        if isValid {
            label.textColor = Pallete.textBlack.color
        } else {
            label.textColor = Pallete.invalidButton.color
        }
        label.textAlignment = .center
        return label
    }()
    
    private lazy var dayOfWeekLable: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Bold", size: 10)
        if isValid {
            label.textColor = Pallete.textBlack.color
        } else {
            label.textColor = Pallete.invalidButton.color
        }
        label.textAlignment = .center
        return label
    }()
    
    private lazy var todayOverlayView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 13.5
        view.layer.borderColor = Pallete.cauBlue.color?.cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        return view
    }()
    
    init(_ idx: Int, date: Date, isValid: Bool) {
        self.buttonIndex = idx
        self.isValid = isValid
        super.init(frame: .zero)
        setLabelsLayout()
        dayLabel.text = date.toDayString()
        dayOfWeekLable.text = date.toDayOfWeekString()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setTodayButton() {
        self.addSubview(todayOverlayView)
        todayOverlayView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(27)
            make.height.equalTo(43)
        }
    }
    
    public func setLablesColorBySelection() {
        dayLabel.textColor = .white
        dayOfWeekLable.textColor = .white
    }
    
    public func setLablesColorByDefault() {
        if isValid {
            dayLabel.textColor = Pallete.textBlack.color
            dayOfWeekLable.textColor = Pallete.textBlack.color
        } else {
            dayLabel.textColor = Pallete.invalidButton.color
            dayOfWeekLable.textColor = Pallete.invalidButton.color
        }
    }
}

extension DateButton {
    private func setLabelsLayout() {
        self.addSubview(dayLabel)
        dayLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        
        self.addSubview(dayOfWeekLable)
        dayOfWeekLable.snp.makeConstraints { make in
            make.top.equalTo(dayLabel.snp.bottom).offset(1)
            make.centerX.equalToSuperview()
        }
    }
}
