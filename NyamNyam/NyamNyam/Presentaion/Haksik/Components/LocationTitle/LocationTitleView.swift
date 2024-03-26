//
//  LocationTitleView.swift
//  NyamNyam
//
//  Created by 박준홍 on 3/26/24.
//

import UIKit

final class LocationTitleView: UIView {
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = Pretendard.semiBold.size(12)
        label.textColor = Pallete.locationText.color
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLocationLabelLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func dismissLocationTitleContent() {
        locationLabel.text = nil
    }
    
    func createLocationTitleContent(_ location: String?) {
        locationLabel.text = location
    }
    
    private func setLocationLabelLayout() {
        self.addSubview(locationLabel)
        locationLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
    }
}
