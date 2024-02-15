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
        let window = UIApplication.shared.windows.first
        guard let topArea = window?.safeAreaInsets.top else { return nil }
        return topArea
    }
    
    private let buttonLabel: UILabel = {
        let label = UILabel()
        label.text = "설정"
        label.font = UIFont(name: "Pretendard-Bold", size: 28)
        label.textColor = .black
        return label
    }()
    
    private let buttonImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "chevron.right")
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
        setBackButtonLabelLayout()
        setBackButtonImageLayout()
        setBackButtonLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BackButtonView {
    
    private func setBackButtonLabelLayout() {
        self.addSubview(buttonLabel)
        buttonLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(31)
            make.top.equalToSuperview().offset((safeAreaTopInset() ?? 50) + 13)
        }
        buttonLabel.isUserInteractionEnabled = false
    }
    
    private func setBackButtonImageLayout() {
        self.addSubview(buttonImage)
        buttonImage.snp.makeConstraints { make in
            make.trailing.equalTo(buttonLabel.snp.leading).offset(-7)
            make.centerY.equalTo(buttonLabel.snp.centerY)
        }
        buttonImage.isUserInteractionEnabled = false
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
