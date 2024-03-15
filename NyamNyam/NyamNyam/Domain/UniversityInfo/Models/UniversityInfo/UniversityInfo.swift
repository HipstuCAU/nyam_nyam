//
//  UniversityInfo.swift
//  NyamNyam
//
//  Created by 박준홍 on 2/10/24.
//

import Foundation

struct UniversityInfo: Equatable {
    let id: String
    let name: String
    let mainColor: String
    let subColor: String
    let campusInfos: [CampusInfo]
    
    init(from dto: UniversityInfoDTO) {
        self.id = dto.universityId
        self.name = dto.name
        self.mainColor = dto.mainColor
        self.subColor = dto.subColor
        self.campusInfos = dto.campusInfos.map { CampusInfo(from: $0) }
    }
}
