//
//  DateSelectView.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/03/05.
//

import UIKit

protocol DateSelectViewDelegate: AnyObject {
    
}

final class DateSelectView: UIView {
    weak var delegate: DateSelectViewDelegate?
    var dateButtons: [DateButton] = []
    private let buttonCount = 7
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = Pallete.skyBlue.color
        initDateButtons()
        setDateButtonsLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initDateButtons() {
        for idx in 0 ..< buttonCount {
            dateButtons.append(DateButton(
                date:Date().convertDay(for: idx))
            )
        }
    }
}

extension DateSelectView {
    private func setDateButtonsLayout() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        var previous: DateButton?
        let width = windowScene.coordinateSpace.bounds.size.width
        let endPointMargin: CGFloat = 20
        let buttonWidth: CGFloat = 27
        let buttonHeight: CGFloat = 43
        
        for idx in 0 ..< buttonCount {
            let current = dateButtons[idx]
            self.addSubview(current)
            current.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.width.equalTo(buttonWidth)
                make.height.equalTo(buttonHeight)
                if idx == 0 {
                    make.leading.equalToSuperview().offset(endPointMargin)
                } else {
                    let margin: CGFloat = endPointMargin * 2
                    let buttonSpacing: CGFloat = (width - margin - buttonWidth) / CGFloat(buttonCount - 1)
                    make.leading.equalTo(previous!.snp.leading).offset(buttonSpacing)
                }
            }
            previous = current
        }
        
    }
}
