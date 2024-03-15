//
//  HaksikService.swift
//  NyamNyam
//
//  Created by 박준홍 on 2024/01/09.
//

import Foundation
import RxSwift

protocol HaksikService {
    func fetchMealPlans() -> Single<[MealPlan]>
}

final class HaksikServiceImpl {
    
    private let repository: MealPlanRepository
  
    private let disposeBag: DisposeBag = .init()
    
    init(repository: MealPlanRepository) {
        self.repository = repository
    }
}

// MARK: - Meal plan repository
extension HaksikServiceImpl: HaksikService {
    func fetchMealPlans() -> Single<[MealPlan]> {
        return repository.fetchMealPlanData()
            .flatMap { mealplansDTO in
                Single.just(mealplansDTO.mealPlans.map { MealPlan(from: $0) })
            }
    }
}
