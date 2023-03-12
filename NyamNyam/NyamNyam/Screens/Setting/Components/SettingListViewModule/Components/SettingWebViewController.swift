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

    override func viewDidLoad() {
        super.viewDidLoad()
        setWebView()
        setWebViewLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
    }
}

private extension SettingWebViewController {
    func setWebView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        let AppInfoURL = URL(string: webURL)
        let AppInfoRequest = URLRequest(url: AppInfoURL!)
        webView.load(AppInfoRequest)
    }
    
    func setWebViewLayout() {
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
