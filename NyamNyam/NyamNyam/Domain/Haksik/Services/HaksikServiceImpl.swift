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
            .flatMap { mealPlanDTOs in
                return Single.just(mealPlanDTOs.map { self.mapMealPlanDTOToMealPlan($0) })
            }
    }
    
    private func mapMealPlanDTOToMealPlan(_ dto: MealPlanDTO) -> MealPlan {
        let date = Date()
        let cafeteriaMealPlans = dto.cafeterias.map { mapMealPlanDTOToCafeteriaMealPlan($0) }
        return MealPlan(date: date, cafeterias: cafeteriaMealPlans)
    }
    
    private func mapMealPlanDTOToCafeteriaMealPlan(_ dto: CafeteriaDTO) -> Cafeteria {
        let meals = dto.meals.map { mapMealDTOToMealType($0) }
        return Cafeteria(cafeteriaID: dto.cafeteriaID, meals: meals)
    }

    private func mapMealDTOToMealType(_ dto: MealDTO) -> Meal {
        let menus = dto.menus.map { mapMenuDTOToMenu($0) }
        let startTime = dto.startTime.convertToDate() ?? Date()
        let endTime = dto.endTime.convertToDate() ?? Date()
        return Meal(mealType: dto.mealType, shouldShowTime: dto.shouldShowTime, startTime: startTime, endTime: endTime, menus: menus)
    }

    private func mapMenuDTOToMenu(_ dto: MenuDTO) -> Menu {
        let price = Int(dto.price) ?? 0
        let startTime = dto.startTime.convertToDate() ?? Date()
        let endTime = dto.endTime.convertToDate() ?? Date()
        let calories = Double(dto.calories) ?? 0.0
        return Menu(menuType: dto.menuType, price: price, startTime: startTime, endTime: endTime, menu: dto.menu, calories: calories)
    }
}
