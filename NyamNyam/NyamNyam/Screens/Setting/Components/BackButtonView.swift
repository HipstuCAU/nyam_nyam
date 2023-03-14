//
//  BackButtonView.swift
//  NyamNyam
//
//  Created by 한택환 on 2023/03/14.
//

import UIKit
import SnapKit

final class BackButtonView: UIView {
    
    func safeAreaTopInset() -> CGFloat? {
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first
            guard let topArea = window?.safeAreaInsets.top else { return nil }
            return topArea
        } else {
            let window = UIApplication.shared.keyWindow
            guard let topArea = window?.safeAreaInsets.top else { return nil }
            return topArea
        }
    }
    
    private let buttonLabel: UILabel = {
        let label = UILabel()
        label.text = "설정"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let buttonImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.left")
        image.sizeToFit()
        image.tintColor = Pallete.gray.color
        return image
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        setBackButtonImageLayout()
        setBackButtonLabelLayout()
        setBackButtonLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BackButtonView {

    private func setBackButtonImageLayout() {
        self.addSubview(buttonImage)
        buttonImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(7.29)
            make.top.equalToSuperview().offset((safeAreaTopInset() ?? 50) + 13)
            make.bottom.equalToSuperview()
            make.height.equalTo(24)
        }
        buttonImage.isUserInteractionEnabled = false
    }
    
    private func setBackButtonLabelLayout() {
        self.addSubview(buttonLabel)
        buttonLabel.snp.makeConstraints { make in
            make.leading.equalTo(buttonImage.snp.trailing).offset(14)
            make.centerY.equalTo(buttonImage.snp.centerY)
            make.top.equalToSuperview().offset((safeAreaTopInset() ?? 50) + 13)
            make.bottom.equalToSuperview()
        }
        buttonLabel.isUserInteractionEnabled = false
    }
    

    private func setBackButtonLayout() {
        self.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.leading.equalTo(buttonImage.snp.leading)
            make.trailing.equalTo(buttonLabel.snp.trailing)
            make.top.equalToSuperview().offset((safeAreaTopInset() ?? 50) + 13)
            make.bottom.equalToSuperview()
        }
        backButton.backgroundColor = .clear
    }
}
