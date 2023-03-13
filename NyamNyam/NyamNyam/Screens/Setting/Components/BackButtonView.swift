//
//  BackButtonView.swift
//  NyamNyam
//
//  Created by 한택환 on 2023/03/14.
//

import UIKit
import SnapKit

final class BackButtonView: UIView {
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
        image.tintColor = Pallete.gray.color
        return image
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        setBackButtonImageLayout()
        setBackButtonLabelLayout()
        setBackButtonLayout()
        
    }
    
    @objc func backButtonPressed(_ sender: UIButton) {
        
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
            make.top.bottom.equalToSuperview()
        }
        buttonImage.isUserInteractionEnabled = false
    }
    
    private func setBackButtonLabelLayout() {
        self.addSubview(buttonLabel)
        buttonLabel.snp.makeConstraints { make in
            make.leading.equalTo(buttonImage.snp.trailing).offset(14)
            make.centerY.equalTo(buttonImage.snp.centerY)
            make.top.bottom.equalToSuperview()
        }
        buttonLabel.isUserInteractionEnabled = false
    }
    

    private func setBackButtonLayout() {
        self.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.leading.equalTo(buttonImage.snp.leading)
            make.trailing.equalTo(buttonLabel.snp.trailing)
            make.top.bottom.equalToSuperview()
        }
        backButton.backgroundColor = .clear
    }
}
