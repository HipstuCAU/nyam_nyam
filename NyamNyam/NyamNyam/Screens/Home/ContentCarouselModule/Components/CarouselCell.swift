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
    
    lazy var scrollView = UIScrollView()
    
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
        scrollView.removeFromSuperview()
        mealCards.forEach { $0.removeFromSuperview() }
        mealCards.removeAll()
    }
    
    public func setDefaultCafeteriaLayout(data: Set<Meal>) {
        // MealTime
        let mealTimes = [MealTime.breakfast, MealTime.lunch, MealTime.dinner]
        
        // Card 마다 유효성 확인해서 생성 / 터치 활성 비활성 결정
        mealTimes.forEach { mealTime in
            var isValid = true
            let filteredData = data.filter {
                $0.mealTime == mealTime && $0.status != .CloseOnWeekends
            }
            if filteredData.count == 0  { isValid = false }
            let mealCard = ExpandableMealCardView(isValid: isValid, mealTime: mealTime)
            mealCards.append(mealCard)
        }
        
        // Card 마다 Layout 설정 (Expand 되기 전)
        (0..<mealCards.count).forEach { idx in
            let card = mealCards[idx]
            scrollView.addSubview(card)
            card.snp.makeConstraints { make in
                make.leading.equalTo(scrollView.snp.leading)
                make.trailing.equalTo(scrollView.snp.trailing)
                if idx == 0 {
                    make.top.equalTo(positionLabel.snp.bottom).offset(7)
                } else {
                    make.top.equalTo(mealCards[idx - 1].snp.bottom).offset(14)
                }
                make.height.equalTo(40)
            }
        }
        
        // ScrollView 전체의 Content Size 결정
        scrollView.contentSize = CGSize(width: contentView.frame.width, height: 50)
        if let lastCard = mealCards.last {
            scrollView.contentLayoutGuide.snp.makeConstraints { make in
                make.leading.equalTo(scrollView.snp.leading)
                make.trailing.equalTo(scrollView.snp.trailing)
                make.top.equalTo(scrollView.snp.top)
                make.bottom.equalTo(lastCard.snp.bottom)
            }
        }
    }
    
    private func getRunningStatus() -> RunningStatus {
        return .running
    }
    
    private func setPositionLabelLayout() {
        scrollView.addSubview(positionLabel)
        positionLabel.snp.makeConstraints { make in
            make.leading.equalTo(scrollView.snp.leading).offset(10)
            make.top.equalTo(scrollView.snp.top).offset(10)
        }
    }
    
    private func setContentViewLayout() {
        contentView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    public func setScrollViewLayout() {
        contentView.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.bottom.equalTo(contentView.snp.bottom)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
        }
        scrollView.isScrollEnabled = true
    }
}
