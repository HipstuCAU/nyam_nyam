//
//  SettingTableViewController.swift
//  NyamNyam
//
//  Created by 한택환 on 2023/03/12.
//

import UIKit
import SnapKit

final class SettingListTableViewController: UIViewController {
    
    private enum SettingTitle: String {
        case linkCAUPortal = "학교 포털 연결"
        case privacyPolicy = "개인정보 정책"
        case question = "문의하기"
    }
    
    private let settingTitle: [SettingTitle] = [.linkCAUPortal, .privacyPolicy, .question]
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = 47
        return tableView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewLayout()
    }
    
}

extension SettingListTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settingTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingListTableViewCell.settingListCellId) as? SettingListTableViewCell else { return UITableViewCell() }
        cell.configureUI(title: settingTitle[indexPath.item].rawValue)
        cell.backgroundColor = .white
        return cell
    }
}

private extension SettingListTableViewController {
    func setTableViewLayout() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.register(SettingListTableViewCell.self, forCellReuseIdentifier: SettingListTableViewCell.settingListCellId)
        tableView.backgroundColor = Pallete.gray50.color
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}
