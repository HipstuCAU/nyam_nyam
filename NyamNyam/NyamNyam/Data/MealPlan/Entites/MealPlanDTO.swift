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
}

struct MealDTO: Codable {
    let name: String
    let menu: [MenuDTO]
}

struct MenuDTO: Codable {
    let price, startTime, endTime: String
    let menu: [String]
}


//struct MenuDTO: Codable {
//    let price: String
//    let startTime: String
//    let endTime: String
//    let menu: [String]
//}
//
//struct CafeteriaDTO: Codable {
//    let name: String
//    let menu: [MenuDTO]
//
//    init() {
//        self.name = ""
//        self.menu = []
//    }
//}
//
//struct DailyMenuDTO: Codable {
//    let date: String
//    var breakfast: [CafeteriaDTO]
//    var lunch: [CafeteriaDTO]
//    var dinner: [CafeteriaDTO]
//    var all: [CafeteriaDTO]
//
//    enum CodingKeys: String, CodingKey {
//        case date
//        case breakfast
//        case lunch
//        case dinner
//        case all
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        date = try container.decode(String.self, forKey: .date)
//        breakfast = (try? container.decode([CafeteriaDTO].self, forKey: .breakfast)) ?? []
//        lunch = (try? container.decode([CafeteriaDTO].self, forKey: .lunch)) ?? []
//        dinner = (try? container.decode([CafeteriaDTO].self, forKey: .dinner)) ?? []
//        all = (try? container.decode([CafeteriaDTO].self, forKey: .all)) ?? []
//    }
//}
//
//
//struct WeeklyMenuDTO: Codable {
//    let campus: String
//    let menuData: [DailyMenuDTO]
//}
