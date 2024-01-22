//
//  DateSelectView.swift
//  NyamNyam
//
//  Created by 박준홍 on 2023/03/05.
//

import UIKit

//protocol DateSelectViewDelegate: AnyObject {
//    func setDateIndex(new: Int)
//    func showToastMessage()
//}
//
//final class DateSelectView: UIView {
//    let viewModel: HomeViewModel
//    weak var delegate: DateSelectViewDelegate?
//    public var dateButtons: [DateButton] = []
//    private let buttonCount = 7
//    private var currentButtonIndex = 0
//    
//    private lazy var selectionOverlayView: UIView = {
//        let view = UIView()
//        view.layer.cornerRadius = 13.5
//        view.backgroundColor = Pallete.cauBlue.color
//        return view
//    }()
//    
//    private lazy var selectionPointView: UIView = {
//        let triangleView = UIView()
//        let triangleLayer = CAShapeLayer()
//
//        let width: CGFloat = 12.0
//        let height: CGFloat = (sqrt(3.0) / 2.0) * width
//
//        let topPoint = CGPoint(x: width / 2.0, y: 0.0)
//        let bottomLeftPoint = CGPoint(x: 0.0, y: height)
//        let bottomRightPoint = CGPoint(x: width, y: height)
//
//        let trianglePath = UIBezierPath()
//        trianglePath.move(to: topPoint)
//        trianglePath.addLine(to: bottomLeftPoint)
//        trianglePath.addLine(to: bottomRightPoint)
//        trianglePath.close()
//
//        triangleLayer.path = trianglePath.cgPath
//        triangleLayer.fillColor = UIColor.white.cgColor
//        triangleView.layer.addSublayer(triangleLayer)
//
//        return triangleView
//    }()
//    
//    init(viewModel: HomeViewModel) {
//        self.viewModel = viewModel
//        super.init(frame: .zero)
//        self.backgroundColor = Pallete.skyBlue.color
//        initDateButtons(dateList: viewModel.dateList)
//        setDateButtonsLayout()
//        setButtonsByDefault()
//        setSelectionStartPoint()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func initDateButtons(dateList: [Date]) {
//        let rawDatas = viewModel.currentCampus.value == .seoul ? viewModel.seoulMeals : viewModel.ansungMeals
//        for idx in 0 ..< dateList.count {
//            var valid: Bool
//            if let dataOfDate = rawDatas.filter({ $0.date == dateList[idx] }).first {
//                if dataOfDate.meals.filter({ $0.status != .CloseOnWeekends }).count > 0 {
//                    valid = true
//                } else {
//                    valid = false
//                }
//            } else {
//                valid = false
//            }
//            let newButton = DateButton(idx, date:dateList[idx], isValid: valid)
//            if newButton.isValid == true {
//                newButton.addTarget(self, action: #selector(validDateButtonPressed), for: .touchUpInside)
//            } else {
//                newButton.addTarget(self, action: #selector(invalidDateButtonPressed), for: .touchUpInside)
//            }
//            dateButtons.append(newButton)
//        }
//    }
//    
//    @objc func validDateButtonPressed(_ sender: DateButton) {
//        delegate?.setDateIndex(new: sender.buttonIndex)
//        currentButtonIndex = sender.buttonIndex
//    }
//    
//    @objc func invalidDateButtonPressed(_ sender: DateButton) {
//        delegate?.showToastMessage()
//    }
//    
//    private func setButtonsByDefault() {
//        for button in dateButtons {
//            if button.buttonIndex == 0 {
//                button.setTodayButton()
//            }
//        }
//    }
//    
//    private func setSelectionStartPoint() {
//        self.addSubview(selectionOverlayView)
//        selectionOverlayView.snp.makeConstraints { make in
//            make.centerX.equalTo(dateButtons[0].snp.centerX)
//            make.centerY.equalToSuperview()
//            make.width.equalTo(27)
//            make.height.equalTo(43)
//        }
//        dateButtons[0].setLablesColorBySelection()
//        bringSubviewToFront(dateButtons[0])
//        dateButtons[0].isUserInteractionEnabled = false
//        
//        self.addSubview(selectionPointView)
//        selectionPointView.snp.makeConstraints { make in
//            make.centerX.equalTo(selectionOverlayView.snp.centerX)
//            make.bottom.equalToSuperview()
//            make.width.equalTo(10)
//            make.height.equalTo(10)
//        }
//        
//    }
//    
//    public func setButtonsBySelection(new selectionIdx: Int) {
//        for button in dateButtons {
//            button.isUserInteractionEnabled = true
//            button.setLablesColorByDefault()
//        }
//        
//        dateButtons[selectionIdx].setLablesColorBySelection()
//        dateButtons[selectionIdx].isUserInteractionEnabled = false
//        self.bringSubviewToFront(self.dateButtons[selectionIdx])
//        
//        self.selectionOverlayView.snp.remakeConstraints { make in
//            make.centerX.equalTo(self.dateButtons[selectionIdx].snp.centerX)
//            make.centerY.equalToSuperview()
//            make.width.equalTo(27)
//            make.height.equalTo(43)
//        }
//        
//        UIView.animate(withDuration: 0.2) {
//            self.selectionOverlayView.superview?.layoutIfNeeded()
//        }
//    }
//}
//
//extension DateSelectView {
//    private func setDateButtonsLayout() {
//        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
//        var previous: DateButton?
//        let width = windowScene.coordinateSpace.bounds.size.width
//        let endPointMargin: CGFloat = 20
//        let buttonWidth: CGFloat = 27
//        
//        for idx in 0 ..< buttonCount {
//            let current = dateButtons[idx]
//            self.addSubview(current)
//            current.snp.makeConstraints { make in
//                make.width.equalTo(buttonWidth)
//                make.top.bottom.equalToSuperview()
//                if idx == 0 {
//                    make.leading.equalToSuperview().offset(endPointMargin)
//                } else {
//                    let margin: CGFloat = endPointMargin * 2
//                    let buttonSpacing: CGFloat = (width - margin - buttonWidth) / CGFloat(buttonCount - 1)
//                    make.leading.equalTo(previous!.snp.leading).offset(buttonSpacing)
//                }
//            }
//            previous = current
//        }
//        
//    }
//}
