//
//  MealPlanRepository.swift
//  NyamNyam
//
//  Created by Sdaq on 2024/01/11.
//

import Foundation
import RxSwift

protocol MealPlanRepository {
    func fetchMealPlan() -> Single<MealPlanDTO>
}

final class MealPlanRepositoryImpl: MealPlanRepository {
    
    private let remoteRepository: MealPlanRemoteRepository
    
    private let localRepository: MealPlanLocalRepository
    
    init(
        remoteRepository: MealPlanRemoteRepository,
        localRepository: MealPlanLocalRepository
    ) {
        self.remoteRepository = remoteRepository
        self.localRepository = localRepository
    }
    
    func fetchMealPlan() -> Single<MealPlanDTO> {
        return Single.create { single in
            Disposables.create()
        }
    }
}
