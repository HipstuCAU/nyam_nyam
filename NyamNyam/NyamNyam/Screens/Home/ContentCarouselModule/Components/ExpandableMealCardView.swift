//
//  ExpandableMealCardView.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/03/10.
//

import UIKit
import SnapKit

final class TimeLabelView: UIView {
    
    private let statusTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    init(status: RunningStatus, data: Meal?) {
        super.init(frame: .zero)
        self.layer.cornerRadius = 11.5
        var labelText: String
        switch status {
        case .running:
            labelText = status.rawValue
            statusTextLabel.textColor = Pallete.blue.color
            statusTextLabel.textAlignment = .center
            self.backgroundColor = Pallete.blueBackground.color
        case .expired:
            labelText = status.rawValue
            statusTextLabel.textColor = Pallete.red.color
            statusTextLabel.textAlignment = .center
            self.backgroundColor = Pallete.redBackground.color
        case .ready:
            labelText = status.rawValue
            statusTextLabel.textColor = Pallete.yellow.color
            statusTextLabel.textAlignment = .center
            self.backgroundColor = Pallete.yellowBackGround.color
        case .notInOperation:
            labelText = status.rawValue
            statusTextLabel.textColor = Pallete.gray.color
            statusTextLabel.textAlignment = .center
            self.backgroundColor = Pallete.grayBackground.color
        }
        
        if let data = data, let start = data.startDate?.makeKoreanDateReverse().toTimeString(), let end = data.endDate?.makeKoreanDateReverse().toTimeString() {
            if data.cafeteria == .cauBurger { labelText += " 09:30~18:30" }
            else if data.cafeteria == .ramen { labelText += " 06:00~23:00" }
            else { labelText += " \(start)~\(end)" }
        }
        
        statusTextLabel.text = labelText
        
        self.addSubview(statusTextLabel)
        
        statusTextLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        self.snp.makeConstraints { make in
            make.leading.equalTo(statusTextLabel).inset(-8)
            make.top.equalTo(statusTextLabel).inset(-4)
            make.trailing.equalTo(statusTextLabel).inset(-8)
            make.bottom.equalTo(statusTextLabel).inset(-4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol ExpandableMealCardViewDelegate: AnyObject {
    func controlCellHeight(isExpanded: Bool, cafeteria: Cafeteria, mealTime: MealTime, needAnimation: Bool)
}

final class ExpandableMealCardView: UIView {
    var isValid: Bool
    var isExpanded: Bool = false
    var mealTime: MealTime
    var cafeteria: Cafeteria
    var date: Date?
    var data: [Meal]?
    var contentColor: UIColor?
    
    weak var delegate: ExpandableMealCardViewDelegate?
    
    var contentViews: [ContentStackView] = []
    
    lazy var mealTimeIconView: UIImageView = {
        let imageView = UIImageView()
        let mealTimeIconName: String
        if mealTime == .breakfast { mealTimeIconName = "sun.and.horizon.fill" }
        else if mealTime == .lunch { mealTimeIconName = "sun.max.fill" }
        else if mealTime == .dinner { mealTimeIconName = "moon.fill" }
        else { mealTimeIconName = "" }
        imageView.image = .init(systemName: mealTimeIconName)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = contentColor
        return imageView
    }()
    
    lazy var mealTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = contentColor
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        return label
    }()

    lazy var expandButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "menuViewButton"), for: .normal)
        button.isUserInteractionEnabled = false
        return button
    }()
    
    init(isValid: Bool, mealTime: MealTime, cafeteria: Cafeteria, data: [Meal]?) {
        self.isValid = isValid
        self.mealTime = mealTime
        self.cafeteria = cafeteria
        self.data = data
        super.init(frame: .zero)
        
        // UI 설정
        self.layer.cornerRadius = 20.0
        backgroundColor = .white
        setExpandButtonLayout()
        
        // isValid 에 따른 타입 설정
        if isValid == true { contentColor = .black }
        else { contentColor = Pallete.gray50.color }
        self.isUserInteractionEnabled = isValid ? true : false
        
        // name content 생성
        setMealTimeIconViewLayout()
        setMealTimeLabelViewLayout()
        
        // mealTimeLabel text
        mealTimeLabel.text = mealTime.rawValue
        
        // Tap 설정
        let tap = UITapGestureRecognizer(target: self, action: #selector(cardPressed))
        self.addGestureRecognizer(tap)
    }
    
    public func setTimeLabel(status: RunningStatus, data: Meal?) {
        let timeLabelView = TimeLabelView(status: status, data: data)
        
        self.addSubview(timeLabelView)
        timeLabelView.snp.makeConstraints { make in
            make.leading.equalTo(mealTimeLabel.snp.trailing).offset(7)
            make.centerY.equalTo(mealTimeLabel.snp.centerY)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func cardPressed() {
        delegate?.controlCellHeight(isExpanded: isExpanded, cafeteria: cafeteria, mealTime: mealTime, needAnimation: true)
    }
}

// MARK: 내부요소 Layout 설정
extension ExpandableMealCardView {
    private func setExpandButtonLayout() {
        self.addSubview(expandButton)
        expandButton.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    private func setMealTimeIconViewLayout() {
        self.addSubview(mealTimeIconView)
        mealTimeIconView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(11)
            if mealTime != .cauburger && mealTime != .ramen {
                make.width.equalTo(23)
                make.height.equalTo(18)
            } else {
                make.width.equalTo(0)
                make.height.equalTo(0)
            }
        }
    }
    
    private func setMealTimeLabelViewLayout() {
        self.addSubview(mealTimeLabel)
        mealTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(mealTimeIconView.snp.trailing).offset(5)
            make.top.equalToSuperview().offset(11)
        }
    }
}
