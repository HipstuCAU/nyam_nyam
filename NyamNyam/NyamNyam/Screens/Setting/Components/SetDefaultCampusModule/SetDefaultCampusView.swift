//
//  SetDefaultCampusView.swift
//  NyamNyam
//
//  Created by 한택환 on 2023/03/13.
//

import UIKit
import SnapKit

protocol SetDefaultCampusViewDelegate: AnyObject {
    func showActionSheet()
}

final class SetDefaultCampusView: UIView {
    
    weak var delegate: SetDefaultCampusViewDelegate?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "기본 캠퍼스 설정"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    let campusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    let campusButtonImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "chevron.forward")
        image.tintColor = Pallete.gray50.color
        return image
    }()
    
    lazy var campusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(campusButtonPressed), for: .touchUpInside)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .clear
        setTitleLayout()
        setCampusLabelLayout()
        setCampusButtonImageLayout()
        setCampusButtonLayout()
        
    }
    
    @objc func campusButtonPressed(_ sender: UIButton) {
        delegate?.showActionSheet()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SetDefaultCampusView {
    func configureUI(_ campus: String) {
        titleLabel.text = campus
    }
}

private extension SetDefaultCampusView {
    
    private func setTitleLayout() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.bottom.equalToSuperview()
        }
    }
    private func setCampusLabelLayout() {
        self.addSubview(campusLabel)
        campusLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(181)
            make.top.bottom.equalToSuperview()
        }
        campusLabel.isUserInteractionEnabled = false
    }
    
    private func setCampusButtonImageLayout() {
        self.addSubview(campusButtonImage)
        campusButtonImage.snp.makeConstraints { make in
            make.leading.equalTo(campusLabel.snp.trailing).offset(7)
            make.top.bottom.equalToSuperview()
            make.height.equalTo(13.49)
            make.width.equalTo(7.87)
        }
        campusButtonImage.isUserInteractionEnabled = false
    }
    private func setCampusButtonLayout() {
        self.addSubview(campusButton)
        campusButton.snp.makeConstraints { make in
            make.leading.equalTo(campusLabel.snp.leading)
            make.trailing.equalTo(campusLabel.snp.trailing)
            make.top.bottom.equalToSuperview()
        }
    }
}
