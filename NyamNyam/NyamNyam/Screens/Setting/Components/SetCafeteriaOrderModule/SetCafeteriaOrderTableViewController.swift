//
//  SetCafeteriaOrderTableViewController.swift
//  NyamNyam
//
//  Created by 한택환 on 2023/03/13.
//

import UIKit
import SnapKit

final class SetCafeteriaOrderTableViewController: UIViewController {
    
    var seoulCafeteriaList: [Cafeteria] = [.chamseulgi, .blueMirA, .blueMirB, .student, .staff]
    var ansungCafeteriaList: [Cafeteria] = [.cauEats, .cauBurger, .ramen]
    
    func getCafeteriaName(_ cafeteria: Cafeteria) -> String {
        switch cafeteria {
        case .chamseulgi:
            return "참슬기"
        case .blueMirA:
            return "생활관A"
        case .blueMirB:
            return "생활관B"
        case .student:
            return "학생식당"
        case .staff:
            return "교직원"
        case .cauEats:
            return "카우이츠"
        case .cauBurger:
            return "카우버거"
        case .ramen:
            return "라면"
        }
    }

    
    let titleLabel: UIView = SetCafeteriaOrderTitleView()
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
        view.backgroundColor = .white
        setTitleLayout()
        setTableViewLayout()
    }
}

private extension SetCafeteriaOrderTableViewController {
    func setTableViewLayout() {
        tableView.register(SetCafeteriaOrderTableViewCell.self, forCellReuseIdentifier: SetCafeteriaOrderTableViewCell.setCafeteriaOrderCellId)
        view.addSubview(tableView)
        tableView.delegate = self
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

extension SetCafeteriaOrderTableViewController: UITableViewDelegate {
}

extension SetCafeteriaOrderTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seoulCafeteriaList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SetCafeteriaOrderTableViewCell.setCafeteriaOrderCellId) as? SetCafeteriaOrderTableViewCell else { return UITableViewCell() }
        cell.configureUI(getCafeteriaName(seoulCafeteriaList[indexPath.row]), String(indexPath.row+1))
        cell.backgroundColor = .white
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveCell = seoulCafeteriaList[sourceIndexPath.row]
        seoulCafeteriaList.remove(at: sourceIndexPath.row)
        seoulCafeteriaList.insert(moveCell, at: destinationIndexPath.row)
        UserDefaults.standard.seoulCafeteria = seoulCafeteriaList.map({
            guard let cafeteria = Cafeteria(rawValue: $0.rawValue) else { fatalError() }
            return cafeteria.rawValue
        })
        print(UserDefaults.standard.seoulCafeteria)
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
