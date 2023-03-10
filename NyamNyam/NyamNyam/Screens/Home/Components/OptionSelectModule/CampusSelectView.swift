//
//  CampusSelectView.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/03/01.
//

import UIKit

protocol CampusSelectViewDelegate: AnyObject {
    func showActionSheet()
}

final class CampusSelectView: UIView {
    
    weak var delegate: CampusSelectViewDelegate?
    
    let campusNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let optionIconView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "chevron.down")
        image.tintColor = Pallete.gray.color
        return image
    }()
    
    lazy var overlappedButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(overlappedButtonPressed), for: .touchUpInside)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        setCampusNameLabelLayout()
        setOptionIconViewLayout()
        setOverlappedButtonLayout()
    }
    
    @objc func overlappedButtonPressed(_ sender: UIButton) {
        delegate?.showActionSheet()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CampusSelectView {
    func setCampusNameLabelLayout() {
        self.addSubview(campusNameLabel)
        campusNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(20)
        }
        campusNameLabel.isUserInteractionEnabled = false
    }
    
    func setOptionIconViewLayout() {
        self.addSubview(optionIconView)
        optionIconView.snp.makeConstraints { make in
            make.centerY.equalTo(campusNameLabel.snp.centerY)
            make.leading.equalTo(campusNameLabel.snp.trailing).offset(1)
            make.width.equalTo(16.19)
            make.height.equalTo(9.44)
        }
        optionIconView.isUserInteractionEnabled = false
    }
    
    func setOverlappedButtonLayout() {
        self.addSubview(overlappedButton)
        overlappedButton.snp.makeConstraints { make in
            make.leading.equalTo(campusNameLabel.snp.leading)
            make.trailing.equalTo(optionIconView.snp.trailing)
            make.top.bottom.equalToSuperview()
        }
    }
}

