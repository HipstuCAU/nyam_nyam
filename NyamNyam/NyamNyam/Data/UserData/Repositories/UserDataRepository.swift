//
//  UserDataRepository.swift
//  NyamNyam
//
//  Created by 박준홍 on 2/11/24.
//

import Foundation
import RxSwift

protocol UserDataRepository {
    func fetchUserUniversityID() -> Single<String>
    func fetchUserUniversityDefaultData(universityID: String) -> Single<DefaultUniversityInfoDTO>
}
