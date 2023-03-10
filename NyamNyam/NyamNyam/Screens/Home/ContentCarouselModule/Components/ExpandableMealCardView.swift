//
//  ExpandableMealCardView.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/03/10.
//

import UIKit
import SnapKit

final class ExpandableMealCardView: UIView {
    
    var isExpanded: Bool
    lazy var expandButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "menuViewButton"), for: .normal)
        button.addTarget(self, action: #selector(expandButtonPressed), for: .touchUpInside)
        return button
    }()
    
    init(isValid: Bool) {
        isExpanded = isValid
        super.init(frame: .zero)
        self.layer.cornerRadius = 20.0
        backgroundColor = .white
        setViewHeight()
        setExpandButtonLayout()
    }
    
    @objc func expandButtonPressed(_ sender: UIButton) {
        if !isExpanded {
            self.snp.updateConstraints { make in
                make.height.equalTo(140)
            }
        } else {
            self.snp.updateConstraints { make in
                make.height.equalTo(40)
            }
        }
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.superview?.layoutIfNeeded()
        }
        isExpanded.toggle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViewHeight() {
        if !isExpanded {
            self.snp.updateConstraints { make in
                make.height.equalTo(40)
            }
        }
    }
    
    private func setExpandButtonLayout() {
        self.addSubview(expandButton)
        expandButton.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}
