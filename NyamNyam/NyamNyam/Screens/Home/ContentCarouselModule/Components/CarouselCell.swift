//
//  CarouselCell.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/03/09.
//

import UIKit
import SnapKit

final class CarouselCell: UICollectionViewCell {
    
    public var cafeteriaType: Cafeteria?
    static let cellId = "contentCell"
    var mealCards: [ExpandableMealCardView] = []
    
    public let positionLabel: UILabel = {
        let label = UILabel()
        label.textColor = Pallete.gray50.color
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private let scrollView = UIScrollView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setContentViewLayout()
        setScrollViewLayout()
        setPositionLabelLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare()
    }
    
    func prepare() {
        mealCards.forEach { $0.removeFromSuperview() }
        mealCards.removeAll()
        let runningStatus = getRunningStatus()
        [MealTime.breakfast, MealTime.lunch, MealTime.dinner].forEach {
            let mealCard = ExpandableMealCardView(isValid: true)
            mealCard.mealTime = $0
            mealCards.append(mealCard)
        }
    }
    
    private func getRunningStatus() -> RunningStatus {
        return .running
    }
    
    private func setMealCardsLayout() {
        
    }
    
    private func setPositionLabelLayout() {
        scrollView.addSubview(positionLabel)
        positionLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(10)
            make.top.equalTo(contentView.snp.top).offset(121)
        }
    }
    
    private func setContentViewLayout() {
        contentView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func setScrollViewLayout() {
        contentView.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.bottom.equalTo(contentView.snp.bottom)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
        }
    }
    
}
