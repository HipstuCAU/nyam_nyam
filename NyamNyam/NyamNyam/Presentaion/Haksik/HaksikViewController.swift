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
import ReactorKit

enum HaksikPresentableAction {
    case appWillEnterForeground
    case viewDidAppear
    case retryLoad
    case dateSelected(Date?)
    case cafeteriaSelected(String?)
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
                                  AlertPresentable,
                                  WithHaptikFeedback {

    weak var listener: HaksikPresentableListener?
    
    private let disposeBag: DisposeBag = .init()
    
    private let actionRelay: PublishRelay<HaksikPresentableListener.Action> = .init()
    
    private let campusTitleView: CampusTitleView = {
        let view = CampusTitleView()
        view.isSkeletonable = true
        view.skeletonCornerRadius = 10.0
        return view
    }()
    
    private let datePickerView: DatePickerView = {
        let view = DatePickerView()
        view.isSkeletonable = true
        return view
    }()
    
    private let cafeteriaPickerBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isSkeletonable = true
        return view
    }()
    
    private let cafeteriaPickerView: CafeteriaPickerView = {
        let view = CafeteriaPickerView()
        return view
    }()
    
    private let locationTitleView: LocationTitleView = {
        let view = LocationTitleView()
        view.isSkeletonable = true
        view.skeletonCornerRadius = 10.0
        return view
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
        
        listener.state.map(\.isLoading)
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .bind(with: self) { owner, loadingStatus in
                if loadingStatus {
                    owner.view.showAnimatedSkeleton(
                        usingColor: Pallete.bgBlue.color ?? .gray
                    )
                } else {
                    owner.view.hideSkeleton()
                    owner.triggerCompleteFeedback()
                }
            }
            .disposed(by: disposeBag)
        

        
        listener.state.map(\.campusTitle)
            .compactMap({ $0 })
            .distinctUntilChanged()
            .observe(on: MainScheduler.asyncInstance)
            .bind(with: self) { owner, title in
                owner.campusTitleView.createCampusTitleContent(
                    title: title
                )
            }
            .disposed(by: disposeBag)
        
        listener.state.map(\.availableDates)
            .compactMap({ $0 })
            .distinctUntilChanged()
            .observe(on: MainScheduler.asyncInstance)
            .bind(with: self) { owner, availableDates in
                owner.datePickerView.createDatePickerContent(
                    startDate: Date(),
                    for: 7,
                    selectedDate: listener.currentState.selectedDate,
                    fetchedDates: availableDates
                )
            }
            .disposed(by: disposeBag)
        
        listener.state.map(\.cafeteriaInfos)
            .compactMap({ $0 })
            .distinctUntilChanged()
            .observe(on: MainScheduler.asyncInstance)
            .bind(with: self) { owner, cafeteriaInfos in
                owner.cafeteriaPickerView.createCafeteriaPicerkContent(
                    cafeterias: cafeteriaInfos,
                    selectedCafeteriaID: listener.currentState.selectedCafeteriaID
                )
            }
            .disposed(by: disposeBag)
        
            
        listener.state.map(\.alertInfo)
            .distinctUntilChanged()
            .compactMap({ $0 })
            .observe(on: MainScheduler.instance)
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
        
        listener.state.map(\.selectedDate)
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .compactMap { $0 }
            .bind(with: self) { owner, date in
                owner.triggerFeedback()
            }
            .disposed(by: disposeBag)
        
        listener.state.map(\.selectedCafeteriaID)
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .compactMap { $0 }
            .bind(with: self) { owner, title in
                owner.triggerRigidFeedback()
            }
            .disposed(by: disposeBag)
        
        listener.state.map(\.locationTitle)
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .compactMap { $0 }
            .bind(with: self) { owner, title in
                owner.locationTitleView.createLocationTitleContent(title)
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
        
        self.datePickerView.selectedDateRelay
            .map { date in .dateSelected(date) }
            .bind(to: self.actionRelay)
            .disposed(by: disposeBag)
        
        self.cafeteriaPickerView.selectedCafeteriaIDRelay
            .map { id in .cafeteriaSelected(id) }
            .bind(to: self.actionRelay)
            .disposed(by: disposeBag)
    }
    
    @objc func willEnterForeground() {
        actionRelay.accept(.appWillEnterForeground)
    }
}

private extension HaksikViewController {
    func configureUI() {
        setBackgroundGradient()
        setCampusTitleViewLayout()
        setDatePickerViewLayout()
        setCafeteriaPickerViewLayout()
        setLocationTitleViewLayout()
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
    
    func setCampusTitleViewLayout() {
        view.addSubview(campusTitleView)
        campusTitleView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-80)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(9)
            make.height.equalTo(40)
        }
    }
    
    func setDatePickerViewLayout() {
        view.addSubview(datePickerView)
        datePickerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(campusTitleView.snp.bottom).offset(12)
            make.height.equalTo(73)
        }
    }
    
    func setCafeteriaPickerViewLayout() {
        view.addSubview(cafeteriaPickerBackgroundView)
        cafeteriaPickerBackgroundView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(datePickerView.snp.bottom)
            make.height.equalTo(54)
        }
        cafeteriaPickerBackgroundView.addSubview(cafeteriaPickerView)
        cafeteriaPickerView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
    }
    
    func setLocationTitleViewLayout() {
        view.addSubview(locationTitleView)
        locationTitleView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.top.equalTo(cafeteriaPickerBackgroundView.snp.bottom).offset(8)
            make.trailing.equalToSuperview().offset(-70)
            make.height.equalTo(22)
        }
    }
}
