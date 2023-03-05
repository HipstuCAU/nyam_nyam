//
//  DateBaseButton.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/03/05.
//

import UIKit

final class DateButton: UIButton {
    
    let dayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = Pallete.textBlack.color
        label.textAlignment = .center
        return label
    }()
    let dayOfWeekLable: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = Pallete.textBlack.color
        label.textAlignment = .center
        return label
    }()
    
    init(date: Date) {
        super.init(frame: .zero)
        setLabelsLayout()
        dayLabel.text = date.toDayString()
        dayOfWeekLable.text = date.toDayOfWeekString()
//
//        self.backgroundColor = .gray
//        dayLabel.backgroundColor = .red
//        dayOfWeekLable.backgroundColor = .blue
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DateButton {
    private func setLabelsLayout() {
        self.addSubview(dayLabel)
        dayLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        self.addSubview(dayOfWeekLable)
        dayOfWeekLable.snp.makeConstraints { make in
            make.top.equalTo(dayLabel.snp.bottom).offset(1)
            make.centerX.equalToSuperview()
        }
    }
}
