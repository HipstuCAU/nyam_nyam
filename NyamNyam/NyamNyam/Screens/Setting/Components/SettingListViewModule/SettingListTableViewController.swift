//
//  SettingTableViewController.swift
//  NyamNyam
//
//  Created by 한택환 on 2023/03/12.
//

import UIKit
import SnapKit
import MessageUI


final class SettingListTableViewController: UIViewController {
    
    enum SettingTitle: String {
//        case linkCAUPortal = "학교 포털 연결"
        case privacyPolicy = "개인정보 정책"
        case question = "문의하기"
    }
    
    private let settingTitle: [SettingTitle] = [.privacyPolicy, .question]
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.isScrollEnabled = false
        tableView.rowHeight = 47
        tableView.backgroundColor = Pallete.bgGray.color
        return tableView
    }()
    
    func webViewCellPressed(webURL: String) {
        let viewController = SettingWebViewController()
            viewController.webURL = webURL
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Pallete.bgGray.color
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

extension SettingListTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch settingTitle[indexPath.row] {
//        case .linkCAUPortal:
//            webViewCellPressed(webURL: "https://mportal.cau.ac.kr/main.do")
        case .privacyPolicy:
            webViewCellPressed(webURL: "https://haksik.notion.site/df3546c909294e73af4570b55655514e")
        case .question:
            touchUpInsideToMailToQuestionPage()
        }
    }
}

private extension SettingListTableViewController {
    func setTableViewLayout() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SettingListTableViewCell.self, forCellReuseIdentifier: SettingListTableViewCell.settingListCellId)
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}

extension SettingListTableViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
    
    private func touchUpInsideToMailToQuestionPage() {
        if MFMailComposeViewController.canSendMail() {
                let composeViewController = MFMailComposeViewController()
                composeViewController.mailComposeDelegate = self
                let bodyString = """
                                 문의 내용을 입력해주세요
                                 """
                
                composeViewController.setToRecipients(["haksik2023@gmail.com"])
                composeViewController.setSubject("[문의]")
                composeViewController.setMessageBody(bodyString, isHTML: false)
                
                self.present(composeViewController, animated: true, completion: nil)
            } else {
                print("메일 보내기 실패")
                let sendMailErrorAlert = UIAlertController(title: "메일 전송 실패", message: "메일을 보내려면 'Mail' 앱이 필요합니다. App Store에서 해당 앱을 복원하거나 이메일 설정을 확인하고 다시 시도해주세요.", preferredStyle: .alert)
                let goAppStoreAction = UIAlertAction(title: "App Store로 이동하기", style: .default) { _ in
                    if let url = URL(string: "https://apps.apple.com/kr/app/mail/id1108187098"), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
                let cancleAction = UIAlertAction(title: "취소", style: .destructive, handler: nil)
                
                sendMailErrorAlert.addAction(goAppStoreAction)
                sendMailErrorAlert.addAction(cancleAction)
                self.present(sendMailErrorAlert, animated: true, completion: nil)
            }
    }
}
