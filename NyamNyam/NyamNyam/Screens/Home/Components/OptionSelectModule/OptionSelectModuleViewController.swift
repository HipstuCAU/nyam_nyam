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
    lazy var dateSelectView = DateSelectView(viewModel: viewModel)
    lazy var cafeteriaSelectView = CafeteriaSelectView(viewModel: viewModel)
    lazy var toastMessage = ToastView()
    var isToastShowing = false
    
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
    
    public func resetModule() {
        viewModel.indexOfDate.value = 0
        viewModel.indexOfCafeteria.value = 0
        
        viewModel.currentCampus.remove(observer: self)
        
        campusSelectView.removeFromSuperview()
        dateSelectView.removeFromSuperview()
        cafeteriaSelectView.removeFromSuperview()
        
        campusSelectView = CampusSelectView()
        dateSelectView = DateSelectView(viewModel: viewModel)
        cafeteriaSelectView = CafeteriaSelectView(viewModel: viewModel)
        
        setCampusSelectViewLayout()
        setDateSelectViewLayout()
        setCafeteriaSelectViewLayout()
        
        campusSelectView.delegate = self
        dateSelectView.delegate = self
        cafeteriaSelectView.cafeteriaDelegate = self
        
        setCampusLabelText()
        
        viewModel.currentCampus.observe(on: self) { [weak self] _ in
            self?.setCampusLabelText()
            self?.resetDateSelectView()
            self?.resetCafeteriaView()
            self?.initOptionIndex()
        }
        
        let index = viewModel.indexOfCafeteria.value
        cafeteriaSelectView.setScrollOffsetBy(buttonIndex: index)
        cafeteriaSelectView.buttons.forEach {
            if $0.buttonIndex == index { $0.isSelected() }
            else { $0.isNotSelected() }
        }
    }
    
    private func resetCafeteriaView() {
        cafeteriaSelectView.removeFromSuperview()
        cafeteriaSelectView = CafeteriaSelectView(viewModel: viewModel)
        setCafeteriaSelectViewLayout()
        cafeteriaSelectView.cafeteriaDelegate = self
    }
    
    private func resetDateSelectView() {
        dateSelectView.removeFromSuperview()
        dateSelectView = DateSelectView(viewModel: viewModel)
        setDateSelectViewLayout()
        dateSelectView.delegate = self
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
    func showToastMessage() {
        if !isToastShowing {
            isToastShowing = true
            toastMessage.alpha = 0.0
            self.view.addSubview(toastMessage)
            toastMessage.snp.remakeConstraints { make in
                make.leading.equalToSuperview().offset(20)
                make.top.equalToSuperview().offset(-80)
                make.width.equalTo(295)
                make.height.equalTo(40)
            }
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.8, animations: { [weak self] in
                self?.toastMessage.alpha = 0.98
                self?.toastMessage.snp.updateConstraints { make in
                    make.top.equalToSuperview().offset(5)
                }
                self?.view.layoutIfNeeded()
            }, completion: { [weak self] _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                    UIView.animate(withDuration: 0.6, animations: {
                        self?.toastMessage.alpha = 0.0
                        self?.toastMessage.snp.updateConstraints { make in
                            make.top.equalToSuperview().offset(-80)
                        }
                        self?.view.layoutIfNeeded()
                    }, completion: { _ in
                        self?.toastMessage.removeFromSuperview()
                        self?.isToastShowing = false
                    })
                }
            })
        }
    }
    
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
