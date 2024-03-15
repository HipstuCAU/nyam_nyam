//
//  CampusInfo.swift
//  NyamNyam
//
//  Created by 박준홍 on 2/14/24.
//

import Foundation

struct CampusInfo: Equatable {
    let id: String
    let name: String
    let cafeteriaInfos: [CafeteriaInfo]
    
    init(from dto: CampusInfoDTO) {
        self.id = dto.campusId
        self.name = dto.name
        self.cafeteriaInfos = dto.cafeteriaInfos.map { CafeteriaInfo(from: $0) }
    }
}
