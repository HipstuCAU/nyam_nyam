//
//  UserCampusInfo.swift
//  NyamNyam
//
//  Created by 박준홍 on 2/14/24.
//

import Foundation

struct UserCampus {
    let id: String
    let cafeteriaIDs: [String]
    
    init(from dto: UserCampusDTO) {
        self.id = dto.id
        self.cafeteriaIDs = dto.cafeteriaIDs
    }
}
