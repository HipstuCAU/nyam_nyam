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
                for button in owner.dayButtons {
                    if button.date == date {
                        button.selectStatus = true
                        owner.selectStatusBackgroundView.snp.remakeConstraints { make in
                            make.directionalEdges.equalTo(button.snp.directionalEdges)
                        }
                        UIView.animate(withDuration: 0.15) {
                            self.layoutIfNeeded()
                        }
                    } else {
                        button.selectStatus = false
                    }
                }
            }
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDatePickerButtons(
        startDate: Date,
        for days: Int,
        selectedDate: Date?
    ) {
        dismissDatePickerButtons()
        
        self.addSubview(selectStatusBackgroundView)
        
        guard days > 0 else { return }
        
        let startDate = startDate.toMidnight() ?? Date()
        
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
        
        if let matchingButton = dayButtons.filter({ $0.date == selectedDate }).first {
            self.selectStatusBackgroundView.snp.makeConstraints { make in
                make.directionalEdges.equalTo(matchingButton.snp.directionalEdges)
            }
            self.layoutIfNeeded()
            self.selectedDateRelay.accept(selectedDate)
        } else {
            
            if let firstButton = dayButtons.first {
                self.selectStatusBackgroundView.snp.makeConstraints { make in
                    make.directionalEdges.equalTo(firstButton.snp.directionalEdges)
                }
            }
            self.layoutIfNeeded()
            self.selectedDateRelay.accept(startDate)
        }
    }
    
    func dismissDatePickerButtons() {
        for dayButton in dayButtons {
            dayButton.removeFromSuperview()
        }
        dayButtons.removeAll()
        buttonDisposeBag = DisposeBag()
        selectStatusBackgroundView.removeFromSuperview()
    }
}
