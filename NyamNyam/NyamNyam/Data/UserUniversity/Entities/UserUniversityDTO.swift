//
//  UserUniversity.swift
//  NyamNyam
//
//  Created by 박준홍 on 2/13/24.
//

import Foundation

struct UserUniversityDTO {
    let id: String
    let defaultCampusID: String
    let userCampuses: [UserCampusDTO]
}
