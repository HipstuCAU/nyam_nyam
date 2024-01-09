//
//  MealPlanDTO.swift
//  NyamNyam
//
//  Created by 한택환 on 1/10/24.
//

import Foundation

struct MenuDTO: Codable {
    let price: String
    let startTime: String
    let endTime: String
    let menu: [String]
}

struct CafeteriaDTO: Codable {
    let name: String
    let menu: [MenuDTO]
}

struct DailyMenuDTO: Codable {
    let date: String
    let breakfast: CafeteriaDTO?
    let lunch: CafeteriaDTO?
    let dinner: CafeteriaDTO?
    let all: CafeteriaDTO?
}

struct WeeklyMenuDTO: Codable {
    let campus: String
    let menuData: [DailyMenuDTO]
}
