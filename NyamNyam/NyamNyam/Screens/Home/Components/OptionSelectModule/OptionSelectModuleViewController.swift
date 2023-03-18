//
//  OptionSelectModuleViewController.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/02/28.
//

import UIKit

final class OptionSelectModuleViewController: UIViewController {
    let viewModel: HomeViewModel
    
    var campusSelectView = CampusSelectView()
    lazy var dateSelectView = DateSelectView(dateList: viewModel.dateList)
    lazy var cafeteriaSelectView = CafeteriaSelectView(viewModel: viewModel)
    
    public func resetModule() {
        campusSelectView.removeFromSuperview()
        dateSelectView.removeFromSuperview()
        cafeteriaSelectView.removeFromSuperview()
        
        campusSelectView = CampusSelectView()
        dateSelectView = DateSelectView(dateList: viewModel.dateList)
        cafeteriaSelectView = CafeteriaSelectView(viewModel: viewModel)
        
        setCampusSelectViewLayout()
        setDateSelectViewLayout()
        setCafeteriaSelectViewLayout()
        
        campusSelectView.delegate = self
        dateSelectView.delegate = self
        cafeteriaSelectView.cafeteriaDelegate = self
        
        setCampusLabelText()
    }
    
    lazy var optionAlert: UIAlertController = {
        let alert = UIAlertController(title: "캠퍼스를 선택해주세요.",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "서울캠퍼스", style: .default , handler:{ (UIAlertAction) in
            self.viewModel.currentCampus.value = .seoul
        }))
        
        alert.addAction(UIAlertAction(title: "안성캠퍼스", style: .default , handler:{ (UIAlertAction) in
            self.viewModel.currentCampus.value = .ansung
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        return alert
    }()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCampusSelectViewLayout()
        setDateSelectViewLayout()
        setCafeteriaSelectViewLayout()
        
        campusSelectView.delegate = self
        dateSelectView.delegate = self
        cafeteriaSelectView.cafeteriaDelegate = self
        
        bind(to: viewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setCampusLabelText()
    }
    
    private func bind(to viewModel: HomeViewModel) {
        viewModel.currentCampus.observe(on: self) { [weak self] _ in
            self?.setCampusLabelText()
            self?.resetCafeteriaView()
            self?.initOptionIndex()
        }
        
        viewModel.indexOfDate.observe(on: self) { [weak self] index in
            self?.dateSelectView.setButtonsBySelection(new: index)
        }
        viewModel.indexOfCafeteria.observe(on: self) { [weak self] index in
            self?.cafeteriaSelectView.setScrollOffsetBy(buttonIndex: index)
            self?.cafeteriaSelectView.buttons.forEach {
                if $0.buttonIndex == index { $0.isSelected() }
                else { $0.isNotSelected() }
            }
        }
    }
    
    private func resetCafeteriaView() {
        cafeteriaSelectView.removeFromSuperview()
        cafeteriaSelectView = CafeteriaSelectView(viewModel: viewModel)
        setCafeteriaSelectViewLayout()
        cafeteriaSelectView.cafeteriaDelegate = self
    }
    
    private func initOptionIndex() {
        viewModel.indexOfDate.value = 0
        viewModel.indexOfCafeteria.value = 0
    }
}

// MARK: - CampusSelectView
extension OptionSelectModuleViewController: CampusSelectViewDelegate {
    func showActionSheet() {
        self.present(optionAlert, animated: true, completion: nil)
    }
    
    private func setCampusSelectViewLayout() {
        view.addSubview(campusSelectView)
        campusSelectView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(41)
        }
    }
    
    private func setCampusLabelText() {
        campusSelectView.campusNameLabel.text = viewModel.currentCampus.value == Campus.seoul ? "서울캠퍼스" : "안성캠퍼스"
    }
}


// MARK: - DateSelectView
extension OptionSelectModuleViewController: DateSelectViewDelegate {
    func setDateIndex(new: Int) {
        viewModel.indexOfDate.value = new
    }
    
    
    private func setDateSelectViewLayout() {
        view.addSubview(dateSelectView)
        dateSelectView.snp.makeConstraints { make in
            make.top.equalTo(campusSelectView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(71)
        }
    }
}

// MARK: - CafeteriaSelectView
extension OptionSelectModuleViewController: CafeteriaSelectViewDelegate {
    func setCafeteriaIndexBy(buttonIdx: Int) {
        viewModel.indexOfCafeteria.value = buttonIdx
    }
    
    private func setCafeteriaSelectViewLayout() {
        view.addSubview(cafeteriaSelectView)
        cafeteriaSelectView.snp.makeConstraints { make in
            make.top.equalTo(dateSelectView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
