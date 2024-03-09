//
//  HomeViewController.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/02/27.
//

import UIKit

import GoogleMobileAds
import SnapKit

final class HomeViewController: UIViewController, GADBannerViewDelegate {
    let viewModel = HomeViewModel()
    lazy var optionSelectModule = OptionSelectModuleViewController(viewModel: viewModel)
    lazy var contentCarouselModule = ContentCarouselModuleViewController(viewModel: viewModel)
    
    lazy var settingButton: UIButton = {
        let button = UIButton()
        button.setImage(.init(named: "setting"), for: .normal)
        button.addTarget(self, action: #selector(settingButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let adBottomBannerView = GADBannerView(adSize: GADAdSizeBanner, origin: .zero)
    
    private func setAdBannerView() {
        self.view.addSubview(adBottomBannerView)
        
        adBottomBannerView.rootViewController = self
        adBottomBannerView.delegate = self
        
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        let width = windowScene.coordinateSpace.bounds.size.width
        adBottomBannerView.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(width)
        adBottomBannerView.backgroundColor = .clear
        
        adBottomBannerView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(adBottomBannerView.adSize.size.width)
            make.height.equalTo(adBottomBannerView.adSize.size.height)
        }
        
        adBottomBannerView.adUnitID = AdmobBanner.appBottom.unitID
        adBottomBannerView.load(GADRequest())
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13, *) {
            return .darkContent
        } else {
            return .default
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        setBackgroundGradient()
        setOptionSelectModuleLayout()
        setContentCarouselModuleLayout()
        setSettingButtonLayout()
        setNetworkAlert()
        setAdBannerView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        optionSelectModule.resetModule()
    }
    
    private func setNetworkAlert() {
        if !Reachability.networkConnected() {
            AlertManager.performAlertAction(of: "netWorkNotConnectedInHome")
        }
    }
    
    @objc func settingButtonPressed(_ sender: UIButton) {
        self.navigationController?.pushViewController(SettingViewController(), animated: true)
    }
    
    func safeAreaTopInset() -> CGFloat {
        let window = UIApplication.shared.windows.first
        guard let topArea = window?.safeAreaInsets.top else { return 50 }
        return topArea
    }
}

extension HomeViewController {
    private func setBackgroundGradient() {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.white.cgColor, Pallete.bgBlue.color!.cgColor]
        layer.frame.size = view.frame.size
        layer.locations = [0.0, 1.0]
        view.layer.insertSublayer(layer, at: 0)
    }
    
    private func setContentCarouselModuleLayout() {
        self.addChild(contentCarouselModule)
        self.view.addSubview(contentCarouselModule.view)
        contentCarouselModule.didMove(toParent: self)
        contentCarouselModule.view.snp.makeConstraints { make in
            make.top.equalTo(optionSelectModule.view
                .snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension HomeViewController {
    private func setOptionSelectModuleLayout() {
        self.addChild(optionSelectModule)
        self.view.addSubview(optionSelectModule.view)
        optionSelectModule.didMove(toParent: self)
        optionSelectModule.view.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(safeAreaTopInset() + 13)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(160)
        }
    }
    
    private func setSettingButtonLayout() {
        view.addSubview(settingButton)
        settingButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(safeAreaTopInset() + 13)
            make.trailing.equalToSuperview().offset(-19)
        }
        
    }
}

