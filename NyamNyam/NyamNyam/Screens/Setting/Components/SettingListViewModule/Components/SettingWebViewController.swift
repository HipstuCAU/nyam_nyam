//
//  SettingWebViewController.swift
//  NyamNyam
//
//  Created by 한택환 on 2023/03/12.
//

import UIKit
import SnapKit
import WebKit

final class SettingWebViewController: UIViewController {
    var webView: WKWebView!
    var webURL: String = ""
    
    lazy var backButton = BackButtonView()
    
    @objc func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setBackButtonLayout()
        backButton.backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        setWebView()
        setWebViewLayout()
        view.insetsLayoutMarginsFromSafeArea = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard Reachability.networkConnected() else {
            let alert = UIAlertController(title: "네트워크가 원활하지 않습니다", message: "연결 상태를 확인해주세요", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "닫기", style: .default) {  _ in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
    }
}

private extension SettingWebViewController {
    
    func setBackButtonLayout() {
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
    }
    
    func setWebView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        let AppInfoURL = URL(string: webURL)
        let AppInfoRequest = URLRequest(url: AppInfoURL!)
        DispatchQueue.main.async {
            self.webView.load(AppInfoRequest)
        }
    }
    
    func setWebViewLayout() {
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
