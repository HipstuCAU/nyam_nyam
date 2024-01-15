//
//  AlertInfo.swift
//  NyamNyam
//
//  Created by Sdaq on 2024/01/15.
//

import Foundation

struct AlertInfo: Equatable {
    let id: String = UUID().uuidString
    let type: AlertType
    let title: String
    let message: String
}
