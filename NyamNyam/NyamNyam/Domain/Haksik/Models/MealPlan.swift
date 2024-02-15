//
//  File.swift
//  NyamNyam
//
//  Created by 박준홍 on 2024/01/11.
//

import Foundation

struct MealPlan: Equatable {
    let date: Date
    let cafeterias: [Cafeteria]
}

struct Cafeteria: Equatable {
    let cafeteriaID: String
    let meals: [Meal]
}

struct Meal: Equatable {
    let mealType: String
    let shouldShowTime: Bool
    let startTime: Date
    let endTime: Date
    let menus: [Menu]
}

struct Menu: Equatable {
    let menuType: String
    let price: Int
    let startTime: Date
    let endTime: Date
    let menu: [String]
    let calories: Double
}
