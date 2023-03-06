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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13, *) {
            return .darkContent
        } else {
            return .default
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setOptionsWithFirstLaunch()
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = .white
        setOptionSelectModuleLayout()
    }
}

extension HomeViewController {
    private func setOptionsWithFirstLaunch() {
        let isFirstLaunch = !UserDefaults.standard.isFirstLaunch
        
        if isFirstLaunch {
            #if DEBUG
            print("First Launch")
            #endif
            UserDefaults.standard.campus = Campus.seoul.rawValue
            // MARK: 이곳에 첫 Launch시 실행할 작업들이 들어갑니다.
            UserDefaults.standard.isFirstLaunch = true
        }
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

