//
//  CardsSkeletonView.swift
//  NyamNyam
//
//  Created by 박준홍 on 3/29/24.
//

import UIKit
import SnapKit
import SkeletonView

final class CardsSkeletonView: UIView {
    
    private var skeletonViews: [UIView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSkeletonViews()
        setSkeletonViewsLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CardsSkeletonView {
    private func createSkeletonViews() {
        for _ in 0 ..< 3 {
            let view = UIView()
            view.isSkeletonable = true
            view.skeletonCornerRadius = 24.0
            skeletonViews.append(view)
        }
    }
    
    private func setSkeletonViewsLayout() {
        var previousView: UIView?
        for idx in 0 ..< skeletonViews.count {
            let skeletonView = skeletonViews[idx]
            self.addSubview(skeletonView)
            skeletonView.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(5)
                make.trailing.equalToSuperview().offset(-5)
                make.height.equalTo(280)
                if let previousView {
                    make.top.equalTo(previousView.snp.bottom).offset(10)
                } else {
                    make.top.equalToSuperview()
                }
            }
            previousView = skeletonView
        }
    }
}

