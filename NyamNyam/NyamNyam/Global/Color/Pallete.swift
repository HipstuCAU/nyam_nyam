//
//  Pallete.swift
//  NyamNyam
//
//  Created by 박준홍 on 2023/03/02.
//

import UIKit

enum Pallete: String {
    case cauBlue
    case cauRed
    case blue
    case red
    case yellow
    case gray
    case gray50
    case gray900
    case skyBlue
    case textBlack
    case bgBlue
    case bgGray
    case divideGray
    case yellowBackGround
    case blueBackground
    case grayBackground
    case redBackground
    case invalidButton
}

extension Pallete {
    var color: UIColor? {
        return .init(named: self.rawValue)
    }
}
