//
//  UserCampusInfo.swift
//  NyamNyam
//
//  Created by 박준홍 on 2/14/24.
//

import Foundation

struct UserCampus: Equatable {
    private let dataIdentifier = UUID()
    let id: String
    let cafeteriaIDs: [String]
    
    init(from dto: UserCampusDTO) {
        self.id = dto.campusId
        self.cafeteriaIDs = dto.cafeteriaIDs
    }
}
