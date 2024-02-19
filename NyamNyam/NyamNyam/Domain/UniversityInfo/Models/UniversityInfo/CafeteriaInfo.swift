//
//  CafeteriaInfo.swift
//  NyamNyam
//
//  Created by 박준홍 on 2/11/24.
//

import Foundation

struct CafeteriaInfo {
    let id: String
    let name: String
    let location: String?
    
    init(from dto: CafeteriaInfoDTO) {
        self.id = dto.cafeteriaId
        self.name = dto.name
        self.location = dto.location
    }
}
