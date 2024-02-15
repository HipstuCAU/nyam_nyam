//
//  MealPlanDTO.swift
//  NyamNyam
//
//  Created by 한택환 on 1/10/24.
//

import Foundation

struct MealPlanDTO: Codable {
    let mealPlan: [WeeklyMealPlanDTO]
    
    enum CodingKeys: String, CodingKey {
        case mealPlan = "results"
    }
}

struct WeeklyMealPlanDTO: Codable {
    let campus: String
    let weeklyMealPlan: [DailyMealPlanDTO]
    
    enum CodingKeys: String, CodingKey {
        case campus
        case weeklyMealPlan = "menuData"
    }
}

struct DailyMealPlanDTO: Codable {
    let date: String
    let breakfast: [MealDTO]
    let lunch: [MealDTO]
    let dinner: [MealDTO]
    let all: [MealDTO]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        date = try container.decode(String.self, forKey: .date)
        breakfast = (try? container.decode([MealDTO].self, forKey: .breakfast)) ?? []
        lunch = (try? container.decode([MealDTO].self, forKey: .lunch)) ?? []
        dinner = (try? container.decode([MealDTO].self, forKey: .dinner)) ?? []
        all = (try? container.decode([MealDTO].self, forKey: .all)) ?? []
    }
}

struct MealDTO: Codable {
    let name: String
    let menu: [MenuDTO]
}

struct MenuDTO: Codable {
    let price: String
    let startTime: String
    let endTime: String
    let menu: [String]
}
