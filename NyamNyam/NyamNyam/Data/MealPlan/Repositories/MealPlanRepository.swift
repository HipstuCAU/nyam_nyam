//
//  MealPlanRepository.swift
//  NyamNyam
//
//  Created by Sdaq on 2024/01/11.
//

import Foundation
import RxSwift

protocol MealPlanRepository {
    func fetchMealPlanData() -> Single<MealPlanDTO>
}

final class MealPlanRepositoryImpl: MealPlanRepository {
    
    private let remoteRepository: MealPlanJsonRemoteRepository
    
    private let localRepository: MealPlanJsonLocalRepository
    
    private let localFileName = "CAUMeals"
    
    private let remoteCollectionName = "CAU_Haksik"
    
    private let remoteDocumentName = "CAU_Cafeteria_Menu"
    
    private var updateValidityTime: Date {
        self.getValidityTime(hour: 2, minute: 30) ?? Date()
    }
    
    init(
        remoteRepository: MealPlanJsonRemoteRepository,
        localRepository: MealPlanJsonLocalRepository
    ) {
        self.remoteRepository = remoteRepository
        self.localRepository = localRepository
    }
    
    func fetchMealPlanData() -> Single<MealPlanDTO> {
        let fetchedJsonString: Single<String>
        
        // 업데이트가 된 적 있고, 업데이트가 아직 유효한 경우
        if let lastUpdateTime = UserDefaults().lastUpdate?.convertToDateWithTime(),
           lastUpdateTime >= updateValidityTime {
            // local
            fetchedJsonString = self.localRepository
                .fetchMealPlanJsonString(
                    fileName: localFileName
                )
        } else {
            // remote + create file to local
            fetchedJsonString = self.remoteRepository
                .fetchMealPlanJsonString(
                    collection: remoteCollectionName,
                    document: remoteDocumentName
                )
                .do(onSuccess: { [weak self] jsonStr in
                    guard let self else { return }
                    do {
                        try self.localRepository
                            .createMealPlanJsonFileWith(
                                jsonString: jsonStr,
                                fileName: self.localFileName
                            )
                    } catch {
                        throw FileError.fileSaveError(error)
                    }
                })
        }
        
        return fetchedJsonString
            .map { jsonString in
                guard let jsonData = jsonString.data(using: .utf8)
                else {
                    throw FileError.invalidData
                }
                
                do {
                    return try JSONDecoder().decode(
                        MealPlanDTO.self,
                        from: jsonData
                    )
                } catch {
                    throw FileError.parsingError(error)
                }
            }
    }
}

// MARK: - for update strategy
extension MealPlanRepositoryImpl {
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
