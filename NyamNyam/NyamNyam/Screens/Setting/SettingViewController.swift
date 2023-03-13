//
//  SettingViewController.swift
//  NyamNyam
//
//  Created by 한택환 on 2023/03/12.
//

import UIKit
import SnapKit

final class SettingViewController: UIViewController {
    lazy var settingListModule = SettingListTableViewController()
    
    func setNavigationBarBackButton() {
        let backBarButtonItem = UIBarButtonItem(title: "설정", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarBackButton()
        self.view.backgroundColor = Pallete.gray50.color
        self.setSettingListLayout()
    }
}

private extension SettingViewController {
    
    private func setSettingListLayout() {
        self.addChild(settingListModule)
        self.view.addSubview(settingListModule.view)
        settingListModule.didMove(toParent: self)
        settingListModule.view.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(490)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
