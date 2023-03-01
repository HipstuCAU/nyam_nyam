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

private extension OptionSelectModuleViewController {
    func setCampusSelectViewLayout() {
        view.addSubview(campusSelectView)
        campusSelectView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(41)
        }
    }
}
