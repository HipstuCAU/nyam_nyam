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
    let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 0
        return view
    }()
    
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
        setStackViewContents()
        setStackViewLayout()
    }
    
    private func setStackViewContents() {
        guard let data = data else { return }
        for row in 0..<(data.menu.count / 2) {
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.alignment = .fill
            rowStackView.distribution = .fillEqually
            rowStackView.spacing = 8
            
            for col in 0..<2 {
                let label = UILabel()
                label.text = "\(data.menu[row * 2 + col])"
                label.textAlignment = .left
                label.textColor = .black
                label.font = .systemFont(ofSize: 16, weight: .semibold)
                rowStackView.addArrangedSubview(label)
            }
            
            stackView.addArrangedSubview(rowStackView)
        }
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
    
    private func setStackViewLayout() {
        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        self.snp.updateConstraints { make in
            make.bottom.equalTo(stackView.snp.bottom)
        }
    }
}
