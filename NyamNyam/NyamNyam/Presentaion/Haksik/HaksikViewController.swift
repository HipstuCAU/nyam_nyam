//
//  HaksikViewController.swift
//  NyamNyam
//
//  Created by 박준홍 on 2024/01/15.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit
import SkeletonView

enum HaksikPresentableAction {
    case appWillEnterForeground
    case viewDidAppear
    case retryLoad
}

protocol HaksikPresentableListener: AnyObject {
    typealias Action = HaksikPresentableAction
    typealias State = HaksikPresentableState
    
    func sendAction(_ action: Action)
    
    var state: Observable<State> { get }
    var currentState: State { get }
}

final class HaksikViewController: UIViewController,
                                  HaksikPresentable,
                                  HaksikViewControllable,
                                  NavigationConfigurable,
                                  AlertPresentable {

    weak var listener: HaksikPresentableListener?
    
    private let disposeBag: DisposeBag = .init()
    
    private let actionRelay: PublishRelay<HaksikPresentableListener.Action> = .init()
    
    private let campusTitleView: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = Pallete.gray900.color
        label.textAlignment = .left
        label.font = Pretendard.bold.size(28.0)
        label.isSkeletonable = true
        label.skeletonTextLineHeight = .relativeToFont
        label.text = " "
        return label
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = Pallete.cauBlue.color
        deactivateNavigation()
        configureUI()
        bindUI()
        bind(listener: listener)
    }
    
    private func bindUI() {
        guard let listener else { return }
        
        let userData = listener.state.map(\.userUniversityData)
            .distinctUntilChanged()
            .compactMap({ $0 })
        
        let universityInfo = listener.state.map(\.universityInfo)
            .distinctUntilChanged()
            .compactMap({ $0 })
        
        Observable.combineLatest(userData, universityInfo)
            .bind(with: self) { owner, data in
                let (userData, universityInfo) = data
                let campusID = userData.defaultCampusID
                let campusTitle = universityInfo.campusInfos
                    .first { $0.id == campusID }?
                    .name
                owner.campusTitleView.hideSkeleton()
                owner.campusTitleView.text = campusTitle
            }
            .disposed(by: disposeBag)
            
        
        listener.state.map(\.isLoading)
            .distinctUntilChanged()
            .bind(with: self) { owner, loadingStatus in
                if loadingStatus {
                    owner.view.showAnimatedSkeleton()
                }
            }
            .disposed(by: disposeBag)
        
        listener.state.map(\.alertInfo)
            .distinctUntilChanged()
            .compactMap({ $0 })
            .bind(with: self) { owner, alertInfo in
                let retryAction = UIAlertAction(
                    title: "재시도",
                    style: .default
                ) { [weak owner] _ in
                    owner?.actionRelay.accept(.retryLoad)
                }
                owner.showAlertOnWindow(
                    alertInfo: alertInfo,
                    actions: [retryAction]
                )
            }
            .disposed(by: disposeBag)
    }
    
    private func bind(listener: HaksikPresentableListener?) {
        guard let listener else { return }
        self.bindActionRelay(listener: listener)
        self.bindActions()
    }
}

// MARK: - Bind Action Relay
private extension HaksikViewController {
    func bindActionRelay(listener: HaksikPresentableListener?) {
        self.actionRelay
            .bind(with: self) { owner, action in
                listener?.sendAction(action)
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - Bind Actions
private extension HaksikViewController {
    func bindActions() {
        self.rx.viewDidAppear
            .map { _ in .viewDidAppear }
            .bind(to: self.actionRelay)
            .disposed(by: disposeBag)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(willEnterForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }
    
    @objc func willEnterForeground() {
        actionRelay.accept(.appWillEnterForeground)
    }
}

private extension HaksikViewController {
    func configureUI() {
        setBackgroundGradient()
        setCampusTitleView()
    }
    
    private func setBackgroundGradient() {
        view.isSkeletonable = true
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor.white.cgColor,
            Pallete.bgBlue.color?.cgColor ?? UIColor.blue
        ]
        layer.frame.size = view.frame.size
        layer.locations = [0.0, 1.0]
        view.layer.insertSublayer(layer, at: 0)
    }
    
    func setCampusTitleView() {
        view.addSubview(campusTitleView)
        campusTitleView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(9)
        }
    }
}
