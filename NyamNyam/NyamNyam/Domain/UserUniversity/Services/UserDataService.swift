//
//  UserDataService.swift
//  NyamNyam
//
//  Created by 박준홍 on 2/11/24.
//

import Foundation
import RxSwift

protocol UserDataService {
    func getUserUniversityID() -> Single<String>
    func getUserUniversityInfo(universityId: String) -> Single<UserUniversityInfo>
}

final class UserDataServiceImpl: UserDataService {
    
    private let repository: UserDataRepository
    
    init(repository: UserDataRepository) {
        self.repository = repository
    }
    
    func getUserUniversityID() -> Single<String> {
        repository.fetchUserUniversityID()
    }
    
    func getUserUniversityInfo(universityId: String) -> Single<UserUniversityInfo> {
        repository.fetchUserUniversityDefaultData(universityID: universityId)
            .map { defaultInfo -> UserUniversityInfo in
                UserUniversityInfo(
                    id: defaultInfo.id,
                    defaultCampusID: defaultInfo.defaultCampusID,
                    defaultCampusInfos: defaultInfo.defaultCampusInfos.map { defaultCampusDTO -> UserCampusInfo in
                        UserCampusInfo(
                            id: defaultCampusDTO.id,
                            cafeteriaIDs: defaultCampusDTO.cafeteriaIDs
                        )
                    }
                )
            }
    }
}
