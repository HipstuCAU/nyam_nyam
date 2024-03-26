//
//  CafeteriaButton.swift
//  NyamNyam
//
//  Created by 박준홍 on 3/24/24.
//

import UIKit

final class CafeteriaButton: UIButton {
    let cafeteriaInfo: CafeteriaInfo
    
    private lazy var cafeteriaLabel: UILabel = {
        let label = UILabel()
        label.text = cafeteriaInfo.name
        label.font = Pretendard.semiBold.size(15.25)
        return label
    }()
    
    var selectStatus: Bool = false {
        didSet {
            cafeteriaLabel.textColor = selectStatus ?
                .white : Pallete.cafeteriaText.color
            
            self.backgroundColor = selectStatus ?
            Pallete.cauBlue.color : Pallete.bgBlue.color
        }
    }
    
    init(cafeteriaInfo: CafeteriaInfo) {
        self.cafeteriaInfo = cafeteriaInfo
        super.init(frame: .zero)
        
        self.layer.cornerRadius = 20.0
        
        self.addSubview(cafeteriaLabel)
        cafeteriaLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(17.25)
            make.trailing.equalToSuperview().offset(-17.25)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


