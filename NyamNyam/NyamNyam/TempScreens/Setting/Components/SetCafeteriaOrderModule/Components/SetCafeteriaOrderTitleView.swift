//
//  SetCafeteriaOrderTitleView.swift
//  NyamNyam
//
//  Created by 한택환 on 2023/03/13.
//

import UIKit
import SnapKit

final class SetCafeteriaOrderTitleView: UIView {
    private let title: UILabel = {
        let label = UILabel()
        label.text = "식당 순서 설정"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        label.textColor = .black
        return label
    }()
    
    private let subTitle: UILabel = {
        let label = UILabel()
        label.text = "설정한 순서는 자동으로 저장돼요"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 12)
        label.textColor = Pallete.gray50.color
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.addSubview(title)
        title.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        
        
        self.addSubview(subTitle)
        subTitle.snp.makeConstraints { make in
            make.leading.equalTo(title.snp.trailing).offset(15)
            make.centerY.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
    }
}
