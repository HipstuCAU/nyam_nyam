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
    lazy var optionSelectModule = OptionSelectModuleViewController(viewModel: viewModel)
    lazy var contentCarouselModule = ContentCarouselModuleViewController(viewModel: viewModel)
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13, *) {
            return .darkContent
        } else {
            return .default
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = .white
        setOptionSelectModuleLayout()
        setContentCarouselModuleLayout()
    }
}

extension HomeViewController {
    private func setContentCarouselModuleLayout() {
        self.addChild(contentCarouselModule)
        self.view.addSubview(contentCarouselModule.view)
        contentCarouselModule.didMove(toParent: self)
        contentCarouselModule.view.snp.makeConstraints { make in
            make.top.equalTo(optionSelectModule.view
                .snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension HomeViewController {
    private func setOptionSelectModuleLayout() {
        self.addChild(optionSelectModule)
        self.view.addSubview(optionSelectModule.view)
        optionSelectModule.didMove(toParent: self)
        optionSelectModule.view.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(63)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(160)
        }
    }
}

