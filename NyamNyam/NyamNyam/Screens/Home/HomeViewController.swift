//
//  HomeViewController.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/02/27.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {
    let viewModel = HomeViewModel()
    lazy var OptionSelectModule = OptionSelectModuleViewController(viewModel: viewModel)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setOptionSelectModuleLayout()
    }
}

extension HomeViewController {
    private func setOptionSelectModuleLayout() {
        self.addChild(OptionSelectModule)
        self.view.addSubview(OptionSelectModule.view)
        OptionSelectModule.didMove(toParent: self)
        OptionSelectModule.view.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(63)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(156)
        }
    }
}

