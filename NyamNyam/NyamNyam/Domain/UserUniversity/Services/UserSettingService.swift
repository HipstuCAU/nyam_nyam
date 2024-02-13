//
//  UserSettingService.swift
//  NyamNyam
//
//  Created by 박준홍 on 2/11/24.
//

import Foundation
import RxSwift

// UserInfo
protocol UserSettingService {
    func getOrderedUniversityInfo() -> Single<OrderedUserInfo>
}

final class UserSettingCompositeServiceImpl: UserSettingService {
    private let universityService: UniversityService
    private let userDataService: UserDataService
    
    init(
        universityService: UniversityService,
        userDataService: UserDataService
    ) {
        self.universityService = universityService
        self.userDataService = userDataService
    }
    
    func getOrderedUniversityInfo() -> Single<OrderedUserInfo> {
        let universityID = userDataService.getUserUniversityID()
        
        let universityInfo = universityID
            .flatMap { id -> Single<UniversityInfo> in
                self.universityService.getUniversityInfo(id: id)
            }
        
        let userUniversityInfo = universityID
            .flatMap { id -> Single<UserUniversityInfo> in
                self.userDataService.getUserUniversityInfo(universityId: id)
            }
        
        return Single.zip(universityInfo, userUniversityInfo) { universityInfo, userUniversityInfo -> OrderedUserInfo in
            OrderedUserInfo(
                defaultCampusID: userUniversityInfo.defaultCampusID,
                userUniversityInfo: userUniversityInfo,
                universityInfo: universityInfo
            )
        }
        
    }
}
