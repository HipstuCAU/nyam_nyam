//
//  Pallete.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/03/02.
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
}

extension Pallete {
    var color: UIColor? {
        return .init(named: self.rawValue)
    }
}
