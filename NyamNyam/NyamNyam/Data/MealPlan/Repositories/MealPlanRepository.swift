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
    
    private let remoteRepository: MealPlanJsonRemoteRepository
    
    private let localRepository: MealPlanJsonLocalRepository
    
    init(
        remoteRepository: MealPlanJsonRemoteRepository,
        localRepository: MealPlanJsonLocalRepository
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
