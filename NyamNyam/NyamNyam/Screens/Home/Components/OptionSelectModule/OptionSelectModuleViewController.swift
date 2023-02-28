//
//  OptionSelectModuleViewController.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/02/28.
//

import UIKit

final class OptionSelectModuleViewController: UIViewController {
    let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
        view.backgroundColor = .yellow
    }
    
    private func bind(to viewModel: HomeViewModel) {
        viewModel.indexOfDate.observe(on: self) { _ in
            print(viewModel.indexOfDate.value)
        }
        viewModel.indexOfCafetera.observe(on: self) { _ in
            print(viewModel.indexOfCafetera.value)
        }
    }
}
