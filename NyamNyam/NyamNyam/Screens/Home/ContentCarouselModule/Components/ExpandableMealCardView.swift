//
//  ExpandableMealCardView.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/03/10.
//

import UIKit
import SnapKit

final class ExpandableMealCardView: UIView {
    var isExpanded: Bool
    var mealTime: MealTime
    var cafeteria: Cafeteria?
    var date: Date?
    var data: [Meal]?
    var contentColor: UIColor?
    
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
    
    init(isValid: Bool, mealTime: MealTime) {
        self.isExpanded = isValid
        self.mealTime = mealTime
        super.init(frame: .zero)
        let tap = UITapGestureRecognizer(target: self, action: #selector(expandButtonPressed))
        self.addGestureRecognizer(tap)
        self.layer.cornerRadius = 20.0
        backgroundColor = .white
        setViewHeight()
        setExpandButtonLayout()
        if isExpanded == true { contentColor = .black }
        else { contentColor = Pallete.gray50.color }
    }
    
    public func setNameContents(date: Date, cafeteria: Cafeteria, data: [Meal]) {
        setMealTimeIconViewLayout()
        setMealTimeLabelViewLayout()
        mealTimeLabel.text = mealTime.rawValue
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
    
    @objc func expandButtonPressed(_ sender: UIButton) {
        if !isExpanded {
            self.snp.updateConstraints { make in
                make.height.equalTo(340)
            }
        } else {
            self.snp.updateConstraints { make in
                make.height.equalTo(40)
            }
        }
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.superview?.layoutIfNeeded()
        }
        isExpanded.toggle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHeight() {
        if !isExpanded {
            self.snp.updateConstraints { make in
                make.height.equalTo(40)
            }
        } else {
            self.snp.updateConstraints { make in
                make.height.equalTo(340)
            }
        }
    }
    
    private func setExpandButtonLayout() {
        self.addSubview(expandButton)
        expandButton.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}
