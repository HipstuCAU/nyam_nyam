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
    let menuType: String
    let price: String
    let startTime: String
    let endTime: String
    let menu: [String]
    let calories: String

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        menuType = (try container.decodeIfPresent(String.self, forKey: .menuType)) ?? ""
        price = (try container.decodeIfPresent(String.self, forKey: .price)) ?? ""
        startTime = (try container.decodeIfPresent(String.self, forKey: .startTime)) ?? ""
        endTime = (try container.decodeIfPresent(String.self, forKey: .endTime)) ?? ""
        menu = try container.decode([String].self, forKey: .menu)
        calories = (try container.decodeIfPresent(String.self, forKey: .calories)) ?? ""
    }
}
