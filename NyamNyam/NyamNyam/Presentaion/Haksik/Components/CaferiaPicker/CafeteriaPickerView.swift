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
    
    private let pickerDisposeBag: DisposeBag = .init()
    
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
                    let button = owner.cafeteriaButtons[idx]
                    if button.cafeteriaInfo.id == id {
                        button.selectStatus = true
                        owner.setScrollOffsetBy(idx: idx, isAnimated: true)
                    } else {
                        button.selectStatus = false
                    }
                }
            }
            .disposed(by: pickerDisposeBag)
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
    
    func createCafeteriaPicerkContent(
        cafeterias: [CafeteriaInfo],
        selectedCafeteriaID: String?
    ) {
        guard cafeterias.count > 0 else { return }
        dismissCafetreiaPickerContent()
        createCafeteriaButtons(cafeterias: cafeterias)
        setCafeteriaButtonsLayout()
        setFirstSelectedButton(selectedCafeteriaID: selectedCafeteriaID)
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

extension CafeteriaPickerView {
    private func createCafeteriaButtons(cafeterias: [CafeteriaInfo]) {
        for cafetera in cafeterias {
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
    }
    
    private func setCafeteriaButtonsLayout() {
        var previousButton: CafeteriaButton? = nil
        
        for cafeteriaButton in cafeteriaButtons {
            self.addSubview(cafeteriaButton)
            cafeteriaButton.snp.makeConstraints { make in
                make.height.equalTo(39)
                make.bottom.equalToSuperview()
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
    }
    
    private func setFirstSelectedButton(selectedCafeteriaID: String?) {
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
}
