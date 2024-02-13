//
//  UniversityService.swift
//  NyamNyam
//
//  Created by 박준홍 on 2/10/24.
//

import Foundation
import RxSwift

protocol UniversityService {
    func getUniversityInfo(id: String) -> Single<UniversityInfo>
}

final class UniversityServiceImpl: UniversityService {
    
    private let universityRepository: UniversityRepository
    
    init(repository: UniversityRepository) {
        self.universityRepository = repository
    }
    
    func getUniversityInfo(id: String) -> Single<UniversityInfo> {
        universityRepository.fetchUniversityInfo(id: id)
            .map { universityDTO -> UniversityInfo in
                return UniversityInfo(
                    id: universityDTO.id,
                    name: universityDTO.name,
                    mainColor: universityDTO.mainColor,
                    subColor: universityDTO.subColor,
                    campusInfos: universityDTO.campusInfos.map { campusDTO -> CampusInfo in
                        CampusInfo(
                            id: campusDTO.id,
                            name: campusDTO.name,
                            cafeteriaInfos: campusDTO.cafeteriaInfos.map { cafeteriaDTO -> CafeteriaInfo in
                                CafeteriaInfo(
                                    id: cafeteriaDTO.id,
                                    name: cafeteriaDTO.name,
                                    location: cafeteriaDTO.location
                                )
                            }
                        )
                    }
                    
                )
            }
        
    }
}
