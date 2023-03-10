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
        setScrollViewLayout()
        mealCards.forEach { $0.removeFromSuperview() }
        mealCards.removeAll()
        guard let cafeteriaType = cafeteriaType else { return }
        if cafeteriaType != .cauBurger && cafeteriaType != .ramen {
            setDefaultCafeteriaLayout()
        } else if cafeteriaType == .cauBurger {
            // TODO: 해당하는 로직 들어가야 함.
        } else if cafeteriaType == .ramen {
            // TODO: 해당하는 로직 들어가야 함.
        }
    }
    
    private func setDefaultCafeteriaLayout() {
        let runningStatus = getRunningStatus()
        var isValid: Bool = false
        if runningStatus == .running || runningStatus == .ready {
            isValid = true
        }
        [MealTime.breakfast, MealTime.lunch, MealTime.dinner].forEach {
            let mealCard = ExpandableMealCardView(isValid: isValid, mealTime: $0)
            mealCards.append(mealCard)
        }
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
            }
        }
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
    
    private func setScrollViewLayout() {
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
