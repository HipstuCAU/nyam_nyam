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

// MARK: - Logic with Remote repository
extension HaksikService {
    
    func getMealPlan() -> Single<MealPlan> {
        repository.fetchMealPlan()
            .map { _ in
                MealPlan()
            }
    }
    
}

// MARK: - Logic with Local repository
extension HaksikService {
    
    
}
