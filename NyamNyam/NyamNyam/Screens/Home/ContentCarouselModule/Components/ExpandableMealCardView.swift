//
//  ExpandableMealCardView.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/03/10.
//

import UIKit
import SnapKit

protocol ExpandableMealCardViewDelegate: AnyObject {
    func controlCellHeight(isExpanded: Bool, cafeteria: Cafeteria, mealTime: MealTime)
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
        else { mealTimeIconName = "moon.fill" }
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
    
    init(isValid: Bool, mealTime: MealTime, cafeteria: Cafeteria) {
        self.isValid = isValid
        self.mealTime = mealTime
        self.cafeteria = cafeteria
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
        mealTimeLabel.text = mealTime.rawValue
        
        // Tap 설정
        let tap = UITapGestureRecognizer(target: self, action: #selector(cardPressed))
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func cardPressed() {
        delegate?.controlCellHeight(isExpanded: isExpanded, cafeteria: cafeteria, mealTime: mealTime)
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
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(11)
            make.width.equalTo(23)
            make.height.equalTo(18)
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
