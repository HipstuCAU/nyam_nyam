//
//  UniversityInfoDTO.swift
//  NyamNyam
//
//  Created by 박준홍 on 2/11/24.
//

import Foundation

struct UniversityInfoDTO: Codable {
    let id: String
    let name: String
    let mainColor: String
    let subColor: String
    let campusInfos: [CampusInfoDTO]
}
