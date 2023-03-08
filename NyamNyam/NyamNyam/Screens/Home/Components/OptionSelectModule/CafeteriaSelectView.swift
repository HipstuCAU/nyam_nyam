//
//  CafeteriaSelectView.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/03/08.
//

import UIKit

protocol CafeteriaSelectViewDelegate: AnyObject {
    func setCafeteriaIndexBy(buttonIdx: Int)
}

final class CafeteriaSelectView: UIScrollView {
    private let cafeteriaList: [Cafeteria]
    public var buttons: [CafeteriaButton] = []
    weak var cafeteriaDelegate: CafeteriaSelectViewDelegate?
    
    init(viewModel: HomeViewModel) {
        cafeteriaList = viewModel.currentCampus.value == .seoul ? viewModel.seoulCafeteriaList : viewModel.ansungCafeteriaList
        super.init(frame: .zero)
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        createCafeteriaButtons()
        setCafeteriaButtonsLayout()
    }
    
    private func setCafeteriaButtonsLayout() {
        var lastButton: CafeteriaButton?
        buttons.forEach {
            self.addSubview($0)
            $0.snp.makeConstraints { make in
                make.top.equalTo(10)
                if let lastButton = lastButton {
                    make.leading.equalTo(lastButton.snp.trailing).offset(10)
                } else {
                    make.leading.equalToSuperview().offset(20)
                }
            }
            lastButton = $0
        }
        if let lastButton = lastButton {
            contentLayoutGuide.snp.makeConstraints { make in
                make.leading.equalTo(20)
                make.trailing.equalTo(lastButton.snp.trailing).offset(20)
                make.top.bottom.equalToSuperview()
            }
        }
    }
    
    private func createCafeteriaButtons() {
        for idx in 0 ..< cafeteriaList.count {
            let name: String
            switch cafeteriaList[idx] {
            case .chamseulgi:
                name = "참슬기"
            case .blueMirA:
                name = "생활관A"
            case .blueMirB:
                name = "생활관B"
            case .student:
                name = "학생식당"
            case .staff:
                name = "교직원"
            case .cauEats:
                name = "카우이츠"
            }
            let button = CafeteriaButton(buttonIndex: idx, name: name)
            button.addTarget(self, action: #selector(cafeteriaButtonPressed), for: .touchUpInside)
            buttons.append(button)
        }
    }
    
    @objc func cafeteriaButtonPressed(_ sender: CafeteriaButton) {
        cafeteriaDelegate?.setCafeteriaIndexBy(buttonIdx: sender.buttonIndex)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setScrollOffsetBy(buttonIndex: Int) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        else { return }
        let contentWidth = contentSize.width
        let sceneWidth = windowScene.screen.bounds.width
        guard contentWidth > sceneWidth else { return }
        let newOffset = ((contentWidth - sceneWidth) / CGFloat(buttons.count - 1) * CGFloat(buttonIndex))
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.contentOffset = CGPoint(x: newOffset, y: 0)
        }
    }
}

