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
    
    public let positionLabel: UILabel = {
        let label = UILabel()
        label.textColor = Pallete.gray50.color
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    public let testView: ExpandableMealCardView = ExpandableMealCardView(isValid: false)
    
    private let scrollView = UIScrollView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setContentViewLayout()
        setScrollViewLayout()
        setPositionLabelLayout()
        setTestViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare()
    }
    
    func prepare() {
        testView.snp.updateConstraints { make in
            make.height.equalTo(40)
        }
        testView.isExpanded = false
    }
    
    private func setTestViewLayout() {
        scrollView.addSubview(testView)
        testView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.top.equalTo(positionLabel.snp.bottom).offset(7)
        }
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
