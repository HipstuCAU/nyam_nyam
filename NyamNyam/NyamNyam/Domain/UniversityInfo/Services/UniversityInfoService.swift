//
//  UniversityService.swift
//  NyamNyam
//
//  Created by 박준홍 on 2/10/24.
//

import Foundation
import RxSwift

protocol UniversityInfoService {
    func getUniversityInfo(id: String) -> Single<UniversityInfo>
}

final class UniversityInfoServiceImpl: UniversityInfoService {
    
    private let universityRepository: UniversityInfoRepository
    
    init(repository: UniversityInfoRepository) {
        self.universityRepository = repository
    }
    
    func getUniversityInfo(id: String) -> Single<UniversityInfo> {
        universityRepository.fetchUniversityInfo(id: id)
            .map { universityInfoDTO -> UniversityInfo in
                UniversityInfo(from: universityInfoDTO)
            }
        
    }
}
