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
    
    init(
        remoteRepository: MealPlanJsonRemoteRepository,
        localRepository: MealPlanJsonLocalRepository
    ) {
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
            .map { _ in
                MealPlan()
            }
    }
}
