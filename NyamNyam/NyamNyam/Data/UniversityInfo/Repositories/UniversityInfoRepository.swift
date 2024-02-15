//
//  UniversityRepository.swift
//  NyamNyam
//
//  Created by 박준홍 on 2/11/24.
//

import Foundation
import RxSwift

protocol UniversityInfoRepository {
    func fetchUniversityInfo(id: String) -> Single<UniversityInfoDTO>
}
