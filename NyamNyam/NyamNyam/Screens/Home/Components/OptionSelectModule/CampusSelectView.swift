//
//  CampusSelectView.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/03/01.
//

import UIKit

final class CampusSelectView: UIView {
    let campusNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .green
        setCampusNameLabelLayout()
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
    }
}

