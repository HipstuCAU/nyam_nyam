//
//  SetCafeteriaOrderTableViewController.swift
//  NyamNyam
//
//  Created by 한택환 on 2023/03/13.
//

import UIKit
import SnapKit

final class SetCafeteriaOrderTableViewController: UIViewController {
    
    private var cafeteriaList: [String]
    private var isSeoulCafeteria: Bool = true
    
    private func getCafeteriaName(_ cafeteria: String) -> String {
        switch cafeteria {
        case "cafeteria":
            return "참슬기"
        case "blueMirA":
            return "생활관A"
        case "blueMirB":
            return "생활관B"
        case "student":
            return "학생식당"
        case "staff":
            return "교직원"
        case "cauEats":
            return "카우이츠"
        case "cauBurger":
            return "카우버거"
        case "ramen":
            return "라면"
        default:
            return "참슬기"
        }
    }
    
    private let titleLabel: UIView = SetCafeteriaOrderTitleView()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = 40
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    init(viewModel: SettingViewModel) {
        if viewModel.currentCampus.value == .seoul {
            cafeteriaList = UserDefaults.standard.seoulCafeteria
            isSeoulCafeteria = true
        } else {
            cafeteriaList = UserDefaults.standard.ansungCafeteria
            isSeoulCafeteria = false
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setTitleLayout()
        setTableViewLayout()
    }
}

private extension SetCafeteriaOrderTableViewController {
    func setTableViewLayout() {
        tableView.register(SetCafeteriaOrderTableViewCell.self, forCellReuseIdentifier: SetCafeteriaOrderTableViewCell.setCafeteriaOrderCellId)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        tableView.dragInteractionEnabled = true
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setTitleLayout() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.leading.equalToSuperview()
        }
    }
}

extension SetCafeteriaOrderTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cafeteriaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SetCafeteriaOrderTableViewCell.setCafeteriaOrderCellId) as? SetCafeteriaOrderTableViewCell else { return UITableViewCell() }
        cell.configureUI(getCafeteriaName(cafeteriaList[indexPath.row]), String(indexPath.row + 1))
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let cell = cafeteriaList[sourceIndexPath.row]
        cafeteriaList.remove(at: sourceIndexPath.row)
        cafeteriaList.insert(cell, at: destinationIndexPath.row)
        if isSeoulCafeteria {
            UserDefaults.standard.seoulCafeteria = cafeteriaList
        } else { UserDefaults.standard.ansungCafeteria = cafeteriaList }
        tableView.reloadData()
    }
}

extension SetCafeteriaOrderTableViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
}

extension SetCafeteriaOrderTableViewController: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if session.localDragSession != nil {
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
    }
}
