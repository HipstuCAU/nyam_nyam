//
//  CafeteriaSelectView.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/03/08.
//

import UIKit

final class CafeteriaSelectView: UIScrollView {
    private let cafeteriaList: [Cafeteria]
    private var buttons: [CafeteriaButton] = []
    
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
            buttons.append(CafeteriaButton(buttonIndex: idx, name: name))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

