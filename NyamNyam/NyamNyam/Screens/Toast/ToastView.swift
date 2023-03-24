//
//  ToastView.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/03/19.
//

import UIKit


final class ToastView: UIView {
    
    let smileImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "smile")
        return view
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "아직 식단이 업데이트 되지 않았어요"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        self.layer.cornerRadius = 20.0
        self.backgroundColor = Pallete.textBlack.color
        self.layer.opacity = 0.98
        setMessageLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setMessageLayout() {
        self.addSubview(smileImageView)
        smileImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(18.0)
        }
        
        self.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(smileImageView.snp.trailing).offset(15)
        }
    }
}
