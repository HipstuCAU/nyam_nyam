//
//  SettingListTableViewCell.swift
//  NyamNyam
//
//  Created by 한택환 on 2023/03/12.
//

import UIKit
import SnapKit

final class SettingListTableViewCell: UITableViewCell {
    static let settingListCellId = "settingListCell"
    private let settingTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-SemiBold", size: 16)
        return label
    }()
    
    private let navigationArrowImageView: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "chevron.forward"))
        image.tintColor = Pallete.gray50.color
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
    
    private func setupLayout(){
        addSubview(settingTitleLabel)
        settingTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        addSubview(navigationArrowImageView)
        navigationArrowImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-14)
            make.centerY.equalToSuperview()
        }
    }
    
    func configureUI(title: String) {
        self.settingTitleLabel.text = title
    }
}
