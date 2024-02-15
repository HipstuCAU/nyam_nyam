//
//  UserDataRepository.swift
//  NyamNyam
//
//  Created by 박준홍 on 2/11/24.
//

import Foundation
import RxSwift

protocol UserUniversityRepository {
    func fetchDefaultUserUniversityID() -> Single<String>
    func fetchUserUniversity(universityID: String) -> Single<UserUniversityDTO>
}
