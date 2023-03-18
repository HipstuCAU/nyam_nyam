//
//  SetCafeteriaOrderTableViewCell.swift
//  NyamNyam
//
//  Created by 한택환 on 2023/03/13.
//

import UIKit
import SnapKit

final class SetCafeteriaOrderTableViewCell: UITableViewCell {
    
    static let setCafeteriaOrderCellId = "setCafeteriaOrderCell"
    
    private let cafeteriaLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        label.textColor = Pallete.gray.color
        return label
    }()
    
    private let switchCafeteriaImageView: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "equal"))
        image.tintColor = Pallete.gray50.color
        return image
    }()
    
    let cafeteriaNumberImageView: UIImageView = {
        let image = UIImageView()
        image.tintColor = Pallete.gray.color
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

private extension SetCafeteriaOrderTableViewCell {
    func setupLayout() {
        self.addSubview(cafeteriaNumberImageView)
        cafeteriaNumberImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(cafeteriaLabel)
        cafeteriaLabel.snp.makeConstraints { make in
            make.leading.equalTo(cafeteriaNumberImageView.snp.trailing).offset(17)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(switchCafeteriaImageView)
        switchCafeteriaImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
}

extension SetCafeteriaOrderTableViewCell {
    func configureUI(_ title: String, _ num: String) {
        cafeteriaLabel.text = title
        cafeteriaNumberImageView.image = UIImage(systemName: "\(num).circle.fill")
    }
}
