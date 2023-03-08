//
//  CafeteriaButton.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/03/08.
//

import UIKit

final class CafeteriaButton: UIButton {
    public var buttonIndex: Int
    
    public let cafeteriaLabel: UILabel = {
        let label = UILabel()
        label.textColor = Pallete.gray50.color ?? .black
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    init(buttonIndex: Int, name: String) {
        self.buttonIndex = buttonIndex
        super.init(frame: .zero)
        cafeteriaLabel.text = name
        setButtonLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButtonLayout() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        else { return }
        self.clipsToBounds = false
        self.backgroundColor = .white
        self.layer.cornerRadius = 15.0
        self.layer.shadowOpacity = 0.1
        self.layer.shadowColor = Pallete.cauBlue.color?.cgColor
        self.layer.shadowRadius = 10.0 / windowScene.screen.scale
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        self.addSubview(cafeteriaLabel)
        cafeteriaLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        self.snp.makeConstraints { make in
            make.width.equalTo(cafeteriaLabel.snp.width).offset(20)
            make.height.equalTo(cafeteriaLabel.snp.height).offset(11)
        }
        self.sizeToFit()
    }
    
    public func isSelected() {
        cafeteriaLabel.textColor = .white
        self.backgroundColor = Pallete.cauBlue.color
    }
    
    public func isNotSelected() {
        cafeteriaLabel.textColor = Pallete.gray50.color ?? .black
        self.backgroundColor = .white
    }
}


