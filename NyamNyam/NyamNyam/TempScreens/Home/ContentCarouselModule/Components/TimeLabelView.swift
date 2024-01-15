//
//  TimeLabelView.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/03/15.
//

import UIKit
import SnapKit

//final class TimeLabelView: UIView {
//    
//    private let statusTextLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont(name: "Pretendard-Bold", size: 12)
//        return label
//    }()
//    
//    init(status: RunningStatus, mealData: Meal?) {
//        super.init(frame: .zero)
//        self.layer.cornerRadius = 11.5
//        var labelText: String
//        switch status {
//        case .running:
//            labelText = status.rawValue
//            statusTextLabel.textColor = Pallete.blue.color
//            statusTextLabel.textAlignment = .center
//            self.backgroundColor = Pallete.blueBackground.color
//        case .expired:
//            labelText = status.rawValue
//            statusTextLabel.textColor = Pallete.red.color
//            statusTextLabel.textAlignment = .center
//            self.backgroundColor = Pallete.redBackground.color
//        case .ready:
//            labelText = status.rawValue
//            statusTextLabel.textColor = Pallete.yellow.color
//            statusTextLabel.textAlignment = .center
//            self.backgroundColor = Pallete.yellowBackGround.color
//        case .notInOperation:
//            labelText = status.rawValue
//            statusTextLabel.textColor = Pallete.gray.color
//            statusTextLabel.textAlignment = .center
//            self.backgroundColor = Pallete.grayBackground.color
//        }
//        
//        if let data = mealData, let start = data.startDate?.makeKoreanDateReverse().toTimeString(), let end = data.endDate?.makeKoreanDateReverse().toTimeString() {
//            if data.cafeteria == .cauBurger { labelText += " 09:30~18:30" }
//            else if data.cafeteria == .ramen { labelText += " 06:00~23:00" }
//            else { labelText += " \(start)~\(end)" }
//        }
//        
//        statusTextLabel.text = labelText
//        
//        self.addSubview(statusTextLabel)
//        
//        statusTextLabel.snp.makeConstraints { make in
//            make.centerX.centerY.equalToSuperview()
//        }
//        
//        self.snp.makeConstraints { make in
//            make.leading.equalTo(statusTextLabel).inset(-8)
//            make.top.equalTo(statusTextLabel).inset(-4)
//            make.trailing.equalTo(statusTextLabel).inset(-8)
//            make.bottom.equalTo(statusTextLabel).inset(-4)
//        }
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
