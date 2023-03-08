//
//  CafeteriaSelectView.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/03/08.
//

import UIKit

final class CafeteriaSelectView: UIView {
    private let cafeteriaList: [Cafeteria]
    
    init(viewModel: HomeViewModel) {
        cafeteriaList = viewModel.currentCampus.value == .seoul ? viewModel.seoulCafeteriaList : viewModel.ansungCafeteriaList
        super.init(frame: .zero)
        self.backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
