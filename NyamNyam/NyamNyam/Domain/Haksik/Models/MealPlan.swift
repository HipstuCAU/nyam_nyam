//
//  File.swift
//  NyamNyam
//
//  Created by 박준홍 on 2024/01/11.
//

import Foundation

struct MealPlan: Equatable {
    private let dataIdentifier = UUID()
    let date: Date
    let cafeterias: [Cafeteria]
    
    init(from dto: MealPlanDTO) {
        self.date = dto.date.convertToDate() ?? Date()
        self.cafeterias = dto.cafeterias.map { Cafeteria(from: $0) }
    }
}

struct Cafeteria: Equatable {
    private let dataIdentifier = UUID()
    let cafeteriaID: String
    let meals: [Meal]
    
    init(from dto: CafeteriaDTO) {
        self.cafeteriaID = dto.cafeteriaID
        self.meals = dto.meals.map { Meal(from: $0) }
    }
}

struct Meal: Equatable {
    private let dataIdentifier = UUID()
    let mealType: String
    let shouldShowTime: Bool
    let startTime: String
    let endTime: String
    let menus: [Menu]
    
    init(from dto: MealDTO) {
        self.mealType = dto.mealType
        self.shouldShowTime = dto.shouldShowTime
        self.startTime = dto.startTime
        self.endTime = dto.endTime
        self.menus = dto.menus.map { Menu(from: $0) }
    }
}

struct Menu: Equatable {
    private let dataIdentifier = UUID()
    let menuType: String?
    let price: Int?
    let startTime: String
    let endTime: String
    let menu: [String]
    let calories: Double?
    
    init(from dto: MenuDTO) {
        self.menuType = dto.menuType
        self.price = dto.price.flatMap(Int.init)
        self.startTime = dto.startTime
        self.endTime = dto.endTime
        self.menu = dto.menu
        self.calories = dto.calories.flatMap(Double.init)
    }
}
