//
//  CampusTitleView.swift
//  NyamNyam
//
//  Created by 박준홍 on 3/16/24.
//

import UIKit
import SnapKit

final class CampusTitleView: UIView {
    private let campusTitleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = Pallete.gray900.color
        label.textAlignment = .left
        label.font = Pretendard.bold.size(28.0)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setCampustTitleLabelLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createCampusTitleContent(title: String?) {
        campusTitleLabel.text = title
    }
    
    func dismissCampusTitleContent() {
        campusTitleLabel.text = nil
    }
    
    private func setCampustTitleLabelLayout() {
        self.addSubview(campusTitleLabel)
        campusTitleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
    }
}

