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
    
    private let remoteRepository: MealPlanRemoteRepository
    
    private let disposeBag: DisposeBag = .init()
    
    init(remoteRepository: MealPlanRemoteRepository) {
        self.remoteRepository = remoteRepository
    }
}

// MARK: - Logic with Remote repository
extension HaksikService {
    
    func getMealPlan() -> Single<String> {
        remoteRepository.fetchMealPlanJsonString()
    }
    
}

// MARK: - Logic with Local repository
extension HaksikService {
    
    
}
