//
//  MockCafeteriaRepository.swift
//  NyamNyam
//
//  Created by 박준홍 on 2/11/24.
//

import Foundation
import RxSwift

final class MockUserUniversityRepositoryImpl: UserUniversityRepository {
    func fetchDefaultUserUniversityID() -> Single<String> {
        return Single<String>.create { single in
            single(.success("K001"))
            return Disposables.create()
        }
    }
    
    func fetchUserUniversity(universityID: String) -> Single<UserUniversityDTO> {
        return Single<UserUniversityDTO>.create { single in
            if universityID == "K001" {
                single(
                    .success(
                        UserUniversityDTO(
                            universityId: "K001",
                            defaultCampusID: "K001001",
                            userCampuses: [
                                UserCampusDTO(
                                    campusId: "K001001",
                                    cafeteriaIDs: ["K001001002", "K001001001", "K001001005", "K001001004", "K001001003"]
                                ),
                                UserCampusDTO(
                                    campusId: "K001002",
                                    cafeteriaIDs: ["K001002006", "K001002008", "K001002007"]
                                ),
                            ]
                        )
                    )
                )
            } else if universityID == "K002" {
                single(
                    .success(
                        UserUniversityDTO(
                            universityId: "K002",
                            defaultCampusID: "K002001",
                            userCampuses: [
                                UserCampusDTO(
                                    campusId: "K002001",
                                    cafeteriaIDs: ["K002001001", "K002001003", "K002001002", "K002001005", "K002001004", "K002001006"]
                                ),
                                UserCampusDTO(
                                    campusId: "K002002",
                                    cafeteriaIDs: ["K002002008", "K002002009", "K002002007", "K002002010", "K002002006", "K002002011"]
                                ),
                            ]
                        )
                    )
                )
            } else {
                single(.failure(FileError.noData))
            }
            return Disposables.create()
        }
    }
}
