//
//  SetCafeteriaOrderTableView.swift
//  NyamNyam
//
//  Created by 한택환 on 2023/03/13.
//

import UIKit
import SnapKit

final class SetCafeteriaOrderTableView: UIViewController {
    
    var seoulCafeteriaList: [String] = UserDefaults.standard.seoulCafeteria
    var ansungCafeteriaList: [String] = UserDefaults.standard.ansungCafeteria
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = 40
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
        print(seoulCafeteriaList)
        setTableViewLayout()
    }
}

private extension SetCafeteriaOrderTableView {
    func setTableViewLayout() {
        tableView.register(SetCafeteriaOrderTableViewCell.self, forCellReuseIdentifier: SetCafeteriaOrderTableViewCell.setCafeteriaOrderCellId)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension SetCafeteriaOrderTableView: UITableViewDelegate {
}

extension SetCafeteriaOrderTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seoulCafeteriaList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SetCafeteriaOrderTableViewCell.setCafeteriaOrderCellId) as? SetCafeteriaOrderTableViewCell else { return UITableViewCell() }
        cell.configureUI(seoulCafeteriaList[indexPath.row], String(indexPath.row+1))
        cell.backgroundColor = .white
        return cell
    }
}
