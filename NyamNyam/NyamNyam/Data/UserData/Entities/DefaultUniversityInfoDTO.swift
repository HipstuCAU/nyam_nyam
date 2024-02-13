//
//  UserUniversity.swift
//  NyamNyam
//
//  Created by 박준홍 on 2/13/24.
//

import Foundation

struct DefaultUniversityInfoDTO {
    let id: String
    let defaultCampusID: String
    let defaultCampusInfos: [DefaultCampusInfoDTO]
}

struct DefaultCampusInfoDTO {
    let id: String
    let cafeteriaIDs: [String]
}
