//
//  OptionSelectModuleViewController.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/02/28.
//

import UIKit

final class OptionSelectModuleViewController: UIViewController {
    let viewModel: HomeViewModel
    
    let campusSelectView = CampusSelectView()
    let dateSetectView = DateSelectView()
    
    lazy var optionAlert: UIAlertController = {
        let alert = UIAlertController(title: "캠퍼스를 선택해주세요.",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "서울캠퍼스", style: .default , handler:{ (UIAlertAction)in
            self.viewModel.currentCampus.value = .seoul
        }))
        
        alert.addAction(UIAlertAction(title: "안성캠퍼스", style: .default , handler:{ (UIAlertAction)in
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
        view.backgroundColor = .yellow
        bind(to: viewModel)
        setCampusSelectViewLayout()
        setDateSelectViewLayout()
        
        campusSelectView.delegate = self
        dateSetectView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setCampusLabelText()
    }
    
    private func bind(to viewModel: HomeViewModel) {
        viewModel.currentCampus.observe(on: self) { _ in
            self.setCampusLabelText()
        }
        
        viewModel.indexOfDate.observe(on: self) { _ in
            
        }
        viewModel.indexOfCafeteria.observe(on: self) { _ in
            
        }
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
    
    private func setDateSelectViewLayout() {
        view.addSubview(dateSetectView)
        dateSetectView.snp.makeConstraints { make in
            make.top.equalTo(campusSelectView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(71)
        }
    }
}
