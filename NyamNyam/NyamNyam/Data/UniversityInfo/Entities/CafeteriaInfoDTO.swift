//
//  CafeteriaInfoDTO.swift
//  NyamNyam
//
//  Created by 박준홍 on 2/11/24.
//

import Foundation

struct CafeteriaInfoDTO: Codable {
    let cafeteriaId: String
    var name: String
    let location: String?
}
