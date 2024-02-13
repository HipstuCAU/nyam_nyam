//
//  Error.swift
//  NyamNyam
//
//  Created by 박준홍 on 2/14/24.
//

import Foundation

enum AppError: Error {
    case referenceError(String)
    
    var localizedDescription: String {
        switch self {
        case let .referenceError(target):
            return "\(target) does not exist in memory."
        }
    }
}
