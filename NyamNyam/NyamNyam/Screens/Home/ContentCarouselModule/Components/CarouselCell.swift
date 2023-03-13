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
    var tempViews: [UIView] = []
    var data: Set<Meal>?
    
    public let positionLabel: UILabel = {
        let label = UILabel()
        label.textColor = Pallete.gray50.color
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
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
        tempViews.forEach { $0.removeFromSuperview() }
        tempViews.removeAll()
        mealCards.forEach { $0.removeFromSuperview() }
        mealCards.removeAll()
        cafeteriaType = nil
        data = nil
    }
    
    public func setDefaultCafeteriaLayout(data: Set<Meal>, mealTimes: [MealTime]) {
        self.data = data
        // MealTime
        let mealTimes = mealTimes
        
        // Card 마다 유효성 확인해서 생성 / 터치 활성 비활성 결정
        mealTimes.forEach { mealTime in
            var isValid = true
            let filteredData = data.filter {
                $0.mealTime == mealTime && $0.status != .CloseOnWeekends
            }
            if filteredData.count == 0  { isValid = false }
            
            // 생성
            guard let cafeteriaType = cafeteriaType else { return }
            let mealCard = ExpandableMealCardView(isValid: isValid, mealTime: mealTime, cafeteria: cafeteriaType)
            mealCard.clipsToBounds = true
            mealCard.delegate = self
            mealCards.append(mealCard)
        }
        
        
        (0..<mealCards.count).forEach { idx in
            let card = mealCards[idx]
            scrollView.addSubview(card)
            
            // view의 높이를 Height가 아닌 Bottom을 기준으로 설정하기 위한 임시 뷰
            // make.bottom.equalTo(tempViewForMakeBottomConstraints.snp.bottom)으로 바꿔주면 view가 줄어든다.
            let tempViewForMakeBottomConstraints: UIView = {
                let view = UIView()
                view.backgroundColor = .clear
                view.isUserInteractionEnabled = false
                return view
            }()
            card.addSubview(tempViewForMakeBottomConstraints)
            tempViews.append(tempViewForMakeBottomConstraints)
            tempViewForMakeBottomConstraints.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview()
                make.height.equalTo(40)
            }
            
            // Card 마다 Layout 설정 (Expand 되기 전)
            card.snp.makeConstraints { make in
                if idx == 0 {
                    make.top.equalTo(positionLabel.snp.bottom).offset(7)
                } else {
                    make.top.equalTo(mealCards[idx - 1].snp.bottom).offset(14)
                }
                make.leading.equalTo(scrollView.snp.leading)
                make.trailing.equalTo(scrollView.snp.trailing)
                make.bottom.equalTo(tempViewForMakeBottomConstraints.snp.bottom)
            }
            
            
        }
        
        
        // 만약에 expired 상태가 아니면, Cell의 각 Card 내부에 data개수 만큼 ContentStackView 넣고 heigt 늘리기
        // 이곳에서 Card의 Expired상태를 검사해야 합니다.
        (0..<mealCards.count).forEach { idx in
            let card = mealCards[idx]
            if card.isValid {
                
                // MARK: Expired되면 여기로 들어올 일이 없어야 한다.
                card.isExpanded = true
                
                // 해당 MealTime에 맞는 data를 순서대로 정렬하여 배열로 생성
                let dataOfCard = data.filter { $0.mealTime == card.mealTime }.sorted(by: <)
                
                var lastContent: ContentStackView?
                
                (0..<dataOfCard.count).forEach { contentIdx in
                    // 내용에 따른 StackView 생성
                    let contentView = ContentStackView()
                    contentView.clipsToBounds = true
                    card.addSubview(contentView)
                    card.contentViews.append(contentView)
                    contentView.backgroundColor = .clear
                    
                    // StackView 내용 채우기
                    contentView.setViewContents(data: dataOfCard[contentIdx])
                    
                    // Divider 생성
                    let divider = DividerView()
                    if contentIdx > 0 {
                        card.addSubview(divider)
                        divider.snp.makeConstraints { make in
                            make.leading.trailing.equalToSuperview()
                            make.top.equalTo(card.contentViews[contentIdx - 1].snp.bottom)
                            if let contentData = contentView.data {
                                if contentData.cafeteria == .student {
                                    make.height.equalTo(5)
                                } else {
                                    make.height.equalTo(40)
                                }
                            }
                        }
                    }
                    
                    
                    
                    // 해당 view layout 설정
                    contentView.snp.makeConstraints { make in
                        if contentIdx == 0 {
                            make.top.equalTo(card.mealTimeIconView.snp.bottom).offset(20)
                        } else {
                            make.top.equalTo(divider.snp.bottom)
                        }
                        make.leading.equalToSuperview().offset(20)
                        make.trailing.equalToSuperview().offset(-20)
                    }
                    // 마지막 콘텐츠 수정 (bottom을 사용하기 위함)
                    lastContent = contentView
                }
                
                if let lastContent = lastContent {
                    card.snp.remakeConstraints { make in
                        if idx == 0 {
                            make.top.equalTo(positionLabel.snp.bottom).offset(7)
                        } else {
                            make.top.equalTo(mealCards[idx - 1].snp.bottom).offset(14)
                        }
                        make.leading.equalTo(scrollView.snp.leading)
                        make.trailing.equalTo(scrollView.snp.trailing)
                        make.bottom.equalTo(lastContent.snp.bottom).offset(20)
                    }
                }
            }
        }
    
        // ScrollView 전체의 Content Size 결정
        scrollView.contentSize = CGSize(width: contentView.frame.width, height: 700)
        if let lastCard = mealCards.last {
            scrollView.contentLayoutGuide.snp.makeConstraints { make in
                make.leading.equalTo(scrollView.snp.leading)
                make.trailing.equalTo(scrollView.snp.trailing)
                make.top.equalTo(scrollView.snp.top)
                make.bottom.equalTo(lastCard.snp.bottom).offset(20)
            }
        }
        layoutIfNeeded()
        
    }
}

extension CarouselCell: ExpandableMealCardViewDelegate {
    func controlCellHeight(isExpanded: Bool, cafeteria: Cafeteria, mealTime: MealTime) {
        if isExpanded == true {
            (0..<mealCards.count).forEach { idx in
                let card = mealCards[idx]
                if card.cafeteria == cafeteria && card.mealTime == mealTime {
                    card.snp.remakeConstraints { make in
                        if idx == 0 {
                            make.top.equalTo(positionLabel.snp.bottom).offset(7)
                        } else {
                            make.top.equalTo(mealCards[idx - 1].snp.bottom).offset(14)
                        }
                        make.leading.equalTo(scrollView.snp.leading)
                        make.trailing.equalTo(scrollView.snp.trailing)
                        make.bottom.equalTo(tempViews[idx].snp.bottom)
                    }
                    UIView.animate(withDuration: 0.5) {
                        self.layoutIfNeeded()
                    }
                    card.isExpanded = false
                }
            }
        } else {
            (0..<mealCards.count).forEach { idx in
                let card = mealCards[idx]
                if card.cafeteria == cafeteria && card.mealTime == mealTime {
                    
                    let lastContent = card.contentViews.last
                    
                    if let lastContent = lastContent {
                        card.snp.remakeConstraints { make in
                            if idx == 0 {
                                make.top.equalTo(positionLabel.snp.bottom).offset(7)
                            } else {
                                make.top.equalTo(mealCards[idx - 1].snp.bottom).offset(14)
                            }
                            make.leading.equalTo(scrollView.snp.leading)
                            make.trailing.equalTo(scrollView.snp.trailing)
                            make.bottom.equalTo(lastContent.snp.bottom).offset(20)
                        }
                    }
                    UIView.animate(withDuration: 0.5) {
                        self.layoutIfNeeded()
                    }
                    card.isExpanded = true
                }
            }
            
        }
    }
}


// subview들 레이아웃 설정
extension CarouselCell {
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
