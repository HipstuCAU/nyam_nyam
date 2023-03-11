//
//  ContentStackView.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/03/10.
//

import UIKit
import SnapKit

final class ContentStackView: UIView {
    var data: Meal?
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setPriceLabelLayout()
    }
    
    
    public func setViewContents(data: Meal) {
        self.data = data
        priceLabel.text = data.price + "원"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContentStackView {
    private func setPriceLabelLayout() {
        self.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
    }
}
