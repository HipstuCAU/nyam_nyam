//
//  HaksikService.swift
//  NyamNyam
//
//  Created by 박준홍 on 2024/01/09.
//

import Foundation
import RxSwift
import RxCocoa

protocol HaksikService {
    func fetchMealPlan() -> Single<MealPlan>
}

final class HaksikServiceImpl {
    
    private let repository: MealPlanRepository
    
    init(repository: MealPlanRepository) {
        self.repository = repository
    }
}

// MARK: - Meal plan repository
extension HaksikServiceImpl: HaksikService {
    
    func fetchMealPlan() -> Single<MealPlan> {
        repository.fetchMealPlanData()
            .map { mealPlan in
                return MealPlan() // TODO: 내려온 데이터로 MealPlan 생성
            }
    }
}
