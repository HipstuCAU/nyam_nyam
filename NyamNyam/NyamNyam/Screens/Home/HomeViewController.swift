//
//  HomeViewController.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/02/27.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    let viewModel = HomeViewModel()

    let testLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(testLabel)
        testLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        testLabel.text = "힙스터들 환영해!!"
        testLabel.textColor = .blue
        testLabel.textAlignment = .center
        testLabel.font = .systemFont(ofSize: 30)
    }


}

