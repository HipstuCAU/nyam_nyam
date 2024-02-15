//
//  MealPlanDTO.swift
//  NyamNyam
//
//  Created by 한택환 on 1/10/24.
//

import Foundation

struct MealPlanDTO: Codable {
    let date: String
    let cafeterias: [CafeteriaDTO]
}

struct CafeteriaDTO: Codable {
    let cafeteriaID: String
    let meals: [MealDTO]
}

struct MealDTO: Codable {
    let mealType: String
    let shouldShowTime: Bool
    let startTime: String
    let endTime: String
    let menus: [MenuDTO]
}

struct MenuDTO: Codable {
    let menuType: String?
    let price: String?
    let startTime: String
    let endTime: String
    let menu: [String]
    let calories: String?
}
