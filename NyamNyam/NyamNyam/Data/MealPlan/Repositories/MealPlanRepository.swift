//
//  MealPlanRepository.swift
//  NyamNyam
//
//  Created by 박준홍 on 2024/01/11.
//

import Foundation
import RxSwift

protocol MealPlanRepository {
    func fetchMealPlanData() -> Single<MealPlansDTO>
}

final class MealPlanCompositeRepositoryImpl: MealPlanRepository {
    
    private let logger = LoggingService(label: "hipstu.NyamNyam")
    
    private let remoteRepository: MealPlanJsonRemoteRepository
    
    private let localRepository: MealPlanJsonLocalRepository
    
    private var updateValidityTime: Date? {
        self.getValidityTime(hour: 2, minute: 30)
    }
    
    init(
        remoteRepository: MealPlanJsonRemoteRepository,
        localRepository: MealPlanJsonLocalRepository
    ) {
        self.remoteRepository = remoteRepository
        self.localRepository = localRepository
    }
    
    func fetchMealPlanData() -> Single<MealPlansDTO> {
        let fetchedJsonString: Single<String>
        
        if let lastUpdateTime = UserDefaults().lastUpdate?.toDateWithTime(),
           let updateValidityTime = updateValidityTime,
           lastUpdateTime >= updateValidityTime {
        
            fetchedJsonString = self.localRepository
                .fetchMealPlanJsonString()
                .debug("📁 local fetch Json")
        } else {
            
            fetchedJsonString = self.remoteRepository
                .fetchMealPlanJsonString()
                .debug("📡 remote fetch Json")
                .do(onSuccess: { [weak self] jsonStr in
                    guard let self else { return }
                    logger.log(
                        level: .info,
                        message: .init(stringLiteral: jsonStr)
                    )
                    do {
                        try self.localRepository
                            .createMealPlanJsonFileWith(
                                jsonString: jsonStr
                            )
                    } catch {
                        logger.log(
                            level: .error,
                            message: .init(stringLiteral: error.localizedDescription)
                        )
                        throw FileError.fileSaveError(error)
                    }
                })
        }
        
        return fetchedJsonString
            .map { [weak self] jsonString in
                guard let self 
                else {
                    throw FileError.unknownError
                }
                guard let jsonData = jsonString.data(using: .utf8)
                else {
                    try localRepository.deleteMealPlanJsonFile()
                    throw FileError.invalidData
                }
                
                do {
                    return try JSONDecoder().decode(
                        MealPlansDTO.self,
                        from: jsonData
                    )
                } catch {
                    logger.log(
                        level: .error,
                        message: .init(stringLiteral: error.localizedDescription)
                    )
                    try localRepository.deleteMealPlanJsonFile()
                    throw FileError.parsingError(error)
                }
            }
    }
}

// MARK: - for update strategy
extension MealPlanCompositeRepositoryImpl {
    private func getValidityTime(hour: Int, minute: Int) -> Date? {
        let calendar = Calendar.current
        let now = Date()
        
        let year = calendar.component(.year, from: now)
        let month = calendar.component(.month, from: now)
        let day = calendar.component(.day, from: now)

        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute

        return calendar.date(from: dateComponents)
    }
}
