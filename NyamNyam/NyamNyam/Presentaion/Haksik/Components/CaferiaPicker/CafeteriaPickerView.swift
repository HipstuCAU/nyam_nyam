//
//  CafeteriaPickerView.swift
//  NyamNyam
//
//  Created by 박준홍 on 3/18/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class CafeteriaPickerView: UIScrollView {
    
    private let disposeBag: DisposeBag = .init()
    
    private var buttonsDisposeBag: DisposeBag = .init()
    
    private var cafeteriaButtons: [CafeteriaButton] = []
    
    let selectedCafeteriaIDRelay: BehaviorRelay<String?> = .init(value: nil)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.canCancelContentTouches = true
        
        selectedCafeteriaIDRelay
            .observe(on: MainScheduler.instance)
            .bind(with: self) { owner, id in
                for idx in 0..<owner.cafeteriaButtons.count {
                    if owner.cafeteriaButtons[idx].cafeteriaInfo.id == id {
                        owner.cafeteriaButtons[idx].selectStatus = true
                        owner.setScrollOffsetBy(idx: idx, isAnimated: true)
                    } else {
                        owner.cafeteriaButtons[idx].selectStatus = false
                    }
                }
            }
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view is CafeteriaButton {
              return true
            }
            return super.touchesShouldCancel(in: view)
    }
    
    func dismissCafetreiaPickerContent() {
        for button in cafeteriaButtons {
            button.removeFromSuperview()
        }
        cafeteriaButtons.removeAll()
        buttonsDisposeBag = DisposeBag()
        self.contentLayoutGuide.snp.removeConstraints()
    }
    
    func createCafeteriaPicerContent(
        cafeteras: [CafeteriaInfo],
        selectedCafeteriaID: String?
    ) {
        dismissCafetreiaPickerContent()

        guard cafeteras.count > 0 else { return }
        
        for cafetera in cafeteras {
            let button = CafeteriaButton(
                cafeteriaInfo: cafetera
            )
            
            button.rx.tap
                .observe(on: MainScheduler.instance)
                .bind(with: self) { owner, _ in
                    owner.selectedCafeteriaIDRelay.accept(cafetera.id)
                }
                .disposed(by: buttonsDisposeBag)
            
            self.cafeteriaButtons.append(button)
        }
        
        var previousButton: CafeteriaButton? = nil
        
        for cafeteriaButton in cafeteriaButtons {
            self.addSubview(cafeteriaButton)
            cafeteriaButton.snp.makeConstraints { make in
                make.height.equalTo(39)
                make.centerY.equalToSuperview()
                if let previousButton {
                    make.leading.equalTo(previousButton.snp.trailing).offset(7)
                } else {
                    make.leading.equalToSuperview().offset(16)
                }
            }
            previousButton = cafeteriaButton
        }
        
        if let previousButton {
            self.contentLayoutGuide.snp.makeConstraints { make in
                make.top.leading.bottom.equalToSuperview()
                make.trailing.equalTo(previousButton.snp.trailing).offset(16)
            }
        }
        
        if let selectedButton = cafeteriaButtons.first(where: { $0.cafeteriaInfo.id == selectedCafeteriaID }) {
            self.selectedCafeteriaIDRelay.accept(selectedButton.cafeteriaInfo.id)
            self.setScrollOffsetBy(
                idx: cafeteriaButtons.firstIndex(of: selectedButton) ?? 0,
                isAnimated: false
            )
        } else {
            if let firstButton = cafeteriaButtons.first {
                self.selectedCafeteriaIDRelay.accept(firstButton.cafeteriaInfo.id)
                self.setScrollOffsetBy(idx: 0, isAnimated: false)
            }
        }
    }
    
    private func setScrollOffsetBy(idx: Int, isAnimated: Bool) {
        let contentWidth = contentSize.width
        let sceneWidth = self.bounds.width
        guard contentWidth > sceneWidth else { return }
        let newOffset = (contentWidth - sceneWidth) / CGFloat(cafeteriaButtons.count - 1) * CGFloat(idx)
        if isAnimated {
            UIView.animate(withDuration: 0.2, delay: 0) {
                self.contentOffset = CGPoint(x: newOffset, y: 0)
            }
        } else {
            self.contentOffset = CGPoint(x: newOffset, y: 0)
        }
    }
}

final class CafeteriaButton: UIButton {
    let cafeteriaInfo: CafeteriaInfo
    
    private lazy var cafeteriaLabel: UILabel = {
        let label = UILabel()
        label.text = cafeteriaInfo.name
        label.font = Pretendard.semiBold.size(15.25)
        return label
    }()
    
    var selectStatus: Bool = false {
        didSet {
            cafeteriaLabel.textColor = selectStatus ?
                .white : Pallete.cafeteriaText.color
            
            self.backgroundColor = selectStatus ?
            Pallete.cauBlue.color : Pallete.bgBlue.color
        }
    }
    
    init(cafeteriaInfo: CafeteriaInfo) {
        self.cafeteriaInfo = cafeteriaInfo
        super.init(frame: .zero)
        
        self.layer.cornerRadius = 20.0
        
        self.addSubview(cafeteriaLabel)
        cafeteriaLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalToSuperview().offset(17.25)
            make.trailing.equalToSuperview().offset(-17.25)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

