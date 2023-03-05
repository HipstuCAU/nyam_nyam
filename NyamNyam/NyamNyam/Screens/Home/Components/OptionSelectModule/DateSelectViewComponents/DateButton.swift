//
//  DateBaseButton.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/03/05.
//

import UIKit

final class DateButton: UIButton {
    public var buttonIndex: Int
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = Pallete.textBlack.color
        label.textAlignment = .center
        return label
    }()
    
    private let dayOfWeekLable: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.textColor = Pallete.textBlack.color
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
    
    init(_ idx: Int, date: Date) {
        buttonIndex = idx
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
        dayLabel.textColor = Pallete.textBlack.color
        dayOfWeekLable.textColor = Pallete.textBlack.color
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
