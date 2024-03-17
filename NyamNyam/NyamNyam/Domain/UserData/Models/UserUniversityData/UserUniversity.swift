//
//  DefaultUniversityInfo.swift
//  NyamNyam
//
//  Created by 박준홍 on 2/14/24.
//

import Foundation

struct UserUniversity: Equatable {
    private let dataIdentifier = UUID()
    let id: String
    let defaultCampusID: String
    let userCampuses: [UserCampus]
    
    init(from dto: UserUniversityDTO) {
        self.id = dto.universityId
        self.defaultCampusID = dto.defaultCampusID
        self.userCampuses = dto.userCampuses.map { UserCampus(from: $0) }
    }
}
