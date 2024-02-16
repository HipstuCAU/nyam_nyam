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
    func getUserUniversity(universityId: String) -> Single<UserUniversity>
}

final class UserDataServiceImpl: UserDataService {
    
    private let userUniversityRepository: UserUniversityRepository
    
    init(userUniversityRepository: UserUniversityRepository) {
        self.userUniversityRepository = userUniversityRepository
    }
    
    func getUserUniversityID() -> Single<String> {
        userUniversityRepository.fetchDefaultUserUniversityID()
    }
    
    func getUserUniversity(universityId: String) -> Single<UserUniversity> {
        userUniversityRepository.fetchUserUniversity(universityID: universityId)
            .map { userUniversityDTO -> UserUniversity in
                UserUniversity(from: userUniversityDTO)
            }
    }
}
