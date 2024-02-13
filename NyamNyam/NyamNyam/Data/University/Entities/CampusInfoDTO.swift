//
//  CampusInfoDTO.swift
//  NyamNyam
//
//  Created by 박준홍 on 2/11/24.
//

import Foundation

struct CampusInfoDTO: Codable {
    let id: String
    let name: String
    let cafeteriaInfos: [CafeteriaInfoDTO]
}
