//
//  Pretendard.swift
//  NyamNyam
//
//  Created by 박준홍 on 3/15/24.
//

import UIKit

enum Pretendard: String {
    case regular = "Pretendard-Regular"
    case semiBold = "Pretendard-SemiBold"
    case bold = "Pretendard-Bold"
    case light = "Pretendard-Light"

    func size(_ size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
