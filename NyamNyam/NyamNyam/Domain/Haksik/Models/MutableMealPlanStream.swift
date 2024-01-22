//
//  MutableMealPlanStream.swift
//  NyamNyam
//
//  Created by 박준홍 on 2024/01/15.
//

import RxSwift
import RxCocoa

protocol MealPlanStream {
    var stream: Observable<MealPlan> { get }
    var value: MealPlan { get }
}

protocol MealPlanMutableStream: MealPlanStream {
    func update(_: MealPlan)
}

final class MealPlanStreamImpl: MealPlanMutableStream {
    private let mealPlanRelay: BehaviorRelay<MealPlan>
    
    var stream: Observable<MealPlan> {
        self.mealPlanRelay.distinctUntilChanged()
    }
    
    var value: MealPlan {
        self.mealPlanRelay.value
    }
    
    init(mealPlan: MealPlan) {
        self.mealPlanRelay = .init(value: mealPlan)
    }
    
    func update(_ mealPlan: MealPlan) {
        self.mealPlanRelay.accept(mealPlan)
    }
}
