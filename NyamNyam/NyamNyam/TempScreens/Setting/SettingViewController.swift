//
//  SettingViewController.swift
//  NyamNyam
//
//  Created by 한택환 on 2023/03/12.
//

import UIKit
import SnapKit

final class SettingViewController: UIViewController {
    
    let viewModel = SettingViewModel()
    
    lazy var settingListModule = SettingListTableViewController()
    lazy var setCafeteriaOrderModule = SetCafeteriaOrderTableViewController(viewModel: viewModel)
    lazy var setDefaultCampusModule = SetDefaultCampusView()
    lazy var backButton = BackButtonView()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13, *) {
            return .darkContent
        } else {
            return .default
        }
    }
    
    lazy var optionAlert: UIAlertController = {
        let alert = UIAlertController(title: "캠퍼스를 선택해주세요.",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "서울캠퍼스", style: .default , handler:{ (UIAlertAction) in
            self.viewModel.currentCampus.value = .seoul
            UserDefaults.standard.campus = Campus.seoul.rawValue
        }))
        
        alert.addAction(UIAlertAction(title: "안성캠퍼스", style: .default , handler:{ (UIAlertAction) in
            self.viewModel.currentCampus.value = .ansung
            UserDefaults.standard.campus = Campus.ansung.rawValue
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        return alert
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultNavigationBar()
        self.setBackButtonLayout()
        backButton.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        self.view.backgroundColor = Pallete.bgGray.color
        self.setDefaultCampusLayout()
        self.setCafeteriaOrderLayout()
        self.setSettingListLayout()
        setDefaultCampusModule.delegate = self
        bind(to: viewModel)
    }
    
    private func bind(to viewModel: SettingViewModel) {
        viewModel.currentCampus.observe(on: self) { [weak self] _ in
            self?.setCampusLabelText()
            self?.resetSetCafeteriaOrderModule()
            self?.resetSettingListModule()
        }
    }
    
    private func resetSetCafeteriaOrderModule() {
        setCafeteriaOrderModule.willMove(toParent: nil)
        setCafeteriaOrderModule.view.removeFromSuperview()
        setCafeteriaOrderModule.removeFromParent()
        setCafeteriaOrderModule = SetCafeteriaOrderTableViewController(viewModel: viewModel)
        setCafeteriaOrderLayout()
    }
    
    private func resetSettingListModule() {
        settingListModule.willMove(toParent: nil)
        settingListModule.view.removeFromSuperview()
        settingListModule.removeFromParent()
        settingListModule = SettingListTableViewController()
        setSettingListLayout()
    }
    
    private func setDefaultNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    @objc func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SettingViewController: SetDefaultCampusViewDelegate {
        func showActionSheet() {
            self.present(optionAlert, animated: true, completion: nil)
        }
    
    private func setCampusLabelText() {
        setDefaultCampusModule.campusLabel.text = viewModel.currentCampus.value == Campus.seoul ? "서울" : "안성"
    }
}

private extension SettingViewController {
    
    func setDefaultCampusLayout() {
        view.addSubview(setDefaultCampusModule)
        setDefaultCampusModule.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(55)
        }
    }
    
    func setCafeteriaOrderLayout() {
        self.addChild(setCafeteriaOrderModule)
        self.view.addSubview(setCafeteriaOrderModule.view)
        setCafeteriaOrderModule.didMove(toParent: self)
        setCafeteriaOrderModule.view.snp.makeConstraints { make in
            make.top.equalTo(setDefaultCampusModule.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(viewModel.currentCampus.value == .seoul ?  UserDefaults.standard.seoulCafeteria.count * 40 + 58 : UserDefaults.standard.ansungCafeteria.count * 40 + 58)
        }
    }
    
    func setSettingListLayout() {
        self.addChild(settingListModule)
        self.view.addSubview(settingListModule.view)
        settingListModule.didMove(toParent: self)
        settingListModule.view.snp.makeConstraints { make in
            make.top.equalTo(setCafeteriaOrderModule.view.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setBackButtonLayout() {
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
    }
}
