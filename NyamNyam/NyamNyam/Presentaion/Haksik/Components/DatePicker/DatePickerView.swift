//
//  DatePickerView.swift
//  NyamNyam
//
//  Created by 박준홍 on 3/16/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class DatePickerView: UIView {
    
    private let disposeBag: DisposeBag = .init()
    
    private var buttonDisposeBag: DisposeBag = .init()
    
    private var dayButtons: [DayPickerButton] = []
    
    private var firstLoaded: Bool = true
    
    private let selectStatusBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Pallete.cauBlue.color
        view.layer.cornerRadius = 15.0
        return view
    }()
    
    let selectedDateRelay: BehaviorRelay<Date?> = .init(value: nil)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Pallete.blueBackground.color
        selectedDateRelay
            .compactMap({ $0 })
            .bind(with: self) { owner, date in
                owner.setSelectStatusBackgroundViewLayout(
                    newDate: date
                )
            }
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createDatePickerContent(
        startDate: Date,
        for days: Int,
        selectedDate: Date?
    ) {
        guard days > 0 else { return }
        dismissDatePickerContent()
        
        let startDate: Date = startDate.toMidnight() ?? Date()
        
        createDateButtons(
            startDate: startDate,
            for: days
        )
        setDateButtonslayout(for: days)
        setFirstSelectedButton(
            startDate: startDate,
            selectedDate: selectedDate
        )
    }
    
    func dismissDatePickerContent() {
        for dayButton in dayButtons {
            dayButton.removeFromSuperview()
        }
        firstLoaded = true
        dayButtons.removeAll()
        buttonDisposeBag = DisposeBag()
        selectStatusBackgroundView.removeFromSuperview()
    }
    
    private func setSelectStatusBackgroundViewLayout(newDate date: Date) {
        for button in self.dayButtons {
            if button.date == date {
                button.selectStatus = true
                self.selectStatusBackgroundView.snp.remakeConstraints { make in
                    make.directionalEdges.equalTo(button.snp.directionalEdges)
                }
                if !firstLoaded {
                    UIView.animate(withDuration: 0.3) {
                        self.layoutIfNeeded()
                    }
                }
            } else {
                button.selectStatus = false
            }
        }
        firstLoaded = false
    }
}

extension DatePickerView {
    private func createDateButtons(
        startDate: Date,
        for days: Int
    ) {
        for day in 0..<days {
            let addedDate = startDate.adding(days: day)
            let dayPickerButton = DayPickerButton(
                frame: .zero,
                date: addedDate
            )
            
            dayPickerButton.rx.tap
                .bind(with: self) { owner, _ in
                    owner.selectedDateRelay.accept(addedDate)
                }
                .disposed(by: buttonDisposeBag)
            
            dayButtons.append(dayPickerButton)
        }
    }
    
    private  func setDateButtonslayout(for days: Int) {
        let buttonWidth: CGFloat = 30.0
        let totalWidth: CGFloat = self.bounds.width
        let totalSpace = totalWidth - (buttonWidth * CGFloat(days))
        let spaceBlock = totalSpace / CGFloat(4 + ((days - 1) * 3))
        
        let screenToButtonSpace: CGFloat = spaceBlock * 2
        
        let buttonToButtonSpace: CGFloat
        if days > 1 {
            buttonToButtonSpace = spaceBlock * 3
        } else {
            buttonToButtonSpace = 0
        }
        
        self.addSubview(selectStatusBackgroundView)
        var previousButton: DayPickerButton? = nil
        for dayButton in dayButtons {
            self.addSubview(dayButton)
            dayButton.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(8)
                make.bottom.equalToSuperview().offset(-13)
                if let previousButton {
                    make.leading.equalTo(previousButton.snp.trailing).offset(buttonToButtonSpace)
                } else {
                    make.leading.equalToSuperview().offset(screenToButtonSpace)
                }
            }
            previousButton = dayButton
        }
        layoutIfNeeded()
    }
    
    private func setFirstSelectedButton(startDate: Date, selectedDate: Date?) {
        if dayButtons.filter({ $0.date == selectedDate }).isEmpty {
            self.selectedDateRelay.accept(startDate)
        } else {
            self.selectedDateRelay.accept(selectedDate)
        }
    }
}
