//
//  MockUniversityRepository.swift
//  NyamNyam
//
//  Created by 박준홍 on 2/10/24.
//

import Foundation
import RxSwift

final class MockUniversityRepositoryImpl: UniversityInfoRepository {
    
    func fetchUniversityInfo(id: String) -> Single<UniversityInfoDTO> {
        return Single<UniversityInfoDTO>.create { single in
            if id == "K001" {
                let universityInfoDTO = UniversityInfoDTO(
                    universityId: "K001",
                    name: "중앙대학교",
                    mainColor: "",
                    subColor: "",
                    campusInfos: [
                        CampusInfoDTO(
                            campusId: "K001001",
                            name: "서울캠퍼스",
                            cafeteriaInfos: [
                                CafeteriaInfoDTO(cafeteriaId: "K001001001", name: "학생식당", location: "법학관(303) B1층"),
                                CafeteriaInfoDTO(cafeteriaId: "K001001002", name: "참슬기", location: "경영경제관(310) B4층"),
                                CafeteriaInfoDTO(cafeteriaId: "K001001003", name: "생활관A", location: "블루미르홀(308)"),
                                CafeteriaInfoDTO(cafeteriaId: "K001001004", name: "생활관B", location: "블루미르홀(309)"),
                                CafeteriaInfoDTO(cafeteriaId: "K001001005", name: "교직원", location: "법학관(303) B1층")
                            ]
                        ),
                        CampusInfoDTO(
                            campusId: "K001002",
                            name: "안성캠퍼스",
                            cafeteriaInfos: [
                                CafeteriaInfoDTO(cafeteriaId: "K001002006", name: "카우이츠", location: "707관"),
                                CafeteriaInfoDTO(cafeteriaId: "K001002007", name: "카우버거", location: "707관"),
                                CafeteriaInfoDTO(cafeteriaId: "K001002008", name: "라면", location: "707관")
                            ]
                        )
                    ]
                )
                single(.success(universityInfoDTO))
                
            } else if id == "K002" {
                let universityInfoDTO = UniversityInfoDTO(
                    universityId: "K002",
                    name: "한양대학교",
                    mainColor: "",
                    subColor: "",
                    campusInfos: [
                        CampusInfoDTO(
                            campusId: "K002001",
                            name: "서울",
                            cafeteriaInfos: [
                                CafeteriaInfoDTO(cafeteriaId: "K002001001", name: "학생식당", location: "학생복지관(한양플라자) 3층"),
                                CafeteriaInfoDTO(cafeteriaId: "K002001002", name: "생활과학관", location: "생활과학관 7층"),
                                CafeteriaInfoDTO(cafeteriaId: "K002001003", name: "신소재공학관", location: "신소재공학관 7층"),
                                CafeteriaInfoDTO(cafeteriaId: "K002001004", name: "1생활관", location: "제1학생생활관 1층"),
                                CafeteriaInfoDTO(cafeteriaId: "K002001005", name: "2생활관", location: "제2학생생활관 1층"),
                                CafeteriaInfoDTO(cafeteriaId: "K002001006", name: "행원파크", location: "행원파크 지하 1층")
                            ]
                        ),
                        CampusInfoDTO(
                            campusId: "K002002",
                            name: "에리카",
                            cafeteriaInfos: [
                                CafeteriaInfoDTO(cafeteriaId: "K002002007", name: "교직원", location: "복지관 3층"),
                                CafeteriaInfoDTO(cafeteriaId: "K002002008", name: "학생식당", location: "복지관 2층"),
                                CafeteriaInfoDTO(cafeteriaId: "K002002009", name: "창의인재원", location: "창의관 1층"),
                                CafeteriaInfoDTO(cafeteriaId: "K002002010", name: "푸드코트", location: "복지관 3층"),
                                CafeteriaInfoDTO(cafeteriaId: "K002002011", name: "창업보육센터", location: "창업보육센터 지하1층")
                            ]
                        )
                    ]
                )
                single(.success(universityInfoDTO))
            } else if id == "K003" {
                let universityInfoDTO = UniversityInfoDTO(
                    universityId: "K003",
                    name: "이화여자대학교",
                    mainColor: "",
                    subColor: "",
                    campusInfos: [
                        CampusInfoDTO(
                            campusId: "K003001",
                            name: "이화여자대학교",
                            cafeteriaInfos: [
                                CafeteriaInfoDTO(cafeteriaId: "K003001001", name: "진선미관", location: "진선미관 (이화·포스코관 옆)"),
                                CafeteriaInfoDTO(cafeteriaId: "K003001002", name: "헬렌관", location: "헬렌관"),
                                CafeteriaInfoDTO(cafeteriaId: "K003001003", name: "공대", location: "신공학관 지하 2층"),
                                CafeteriaInfoDTO(cafeteriaId: "K003001004", name: "한우리집", location: "한우리집 지하 1층"),
                                CafeteriaInfoDTO(cafeteriaId: "K003001005", name: "E-House", location: "이하우스 201동")
                            ]
                        )
                    ]
                )
                single(.success(universityInfoDTO))
            } else {
                single(.failure(FirebaseDataError.noData))
            }
            return Disposables.create()
        }
    }
}
