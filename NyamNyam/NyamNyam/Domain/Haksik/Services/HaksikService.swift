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
    
    init(repository: MealPlanRepository) {
        self.repository = repository
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
