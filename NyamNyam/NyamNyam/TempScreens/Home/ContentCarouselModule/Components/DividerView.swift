//
//  DividerView.swift
//  NyamNyam
//
//  Created by 박준홍 on 2023/03/13.
//

import UIKit

final class DividerView: UIView {
    
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = Pallete.divideGray.color
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        setDividerLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setDividerLayout() {
        self.addSubview(divider)
        divider.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
