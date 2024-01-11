//
//  HaksikService.swift
//  NyamNyam
//
//  Created by Sdaq on 2024/01/09.
//

import Foundation
import RxSwift
import RxCocoa

final class HaksikService {
    
    private let repository: MealPlanRepository
    
    private let disposeBag: DisposeBag = .init()
    
    init() {
        let remoteRepository = MockMealPlanJsonRemoteRepositoryImpl()
        
        let localRepository = MealPlanJsonLocalRepositoryImpl()
        
        self.repository = MealPlanRepositoryImpl(
            remoteRepository: remoteRepository,
            localRepository: localRepository
        )
    }
}

// MARK: - Meal plan repository
extension HaksikService {
    
    func fetchMealPlan() -> Single<MealPlan> {
        repository.fetchMealPlanData()
            .debug()
            .map { _ in
                MealPlan()
            }
    }
}
