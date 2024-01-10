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
    
    init() {
        self.name = ""
        self.menu = []
    }
}

struct DailyMenuDTO: Codable {
    let date: String
    var breakfast: CafeteriaDTO
    var lunch: CafeteriaDTO
    var dinner: CafeteriaDTO
    var all: CafeteriaDTO

    enum CodingKeys: String, CodingKey {
        case date
        case breakfast
        case lunch
        case dinner
        case all
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        date = try container.decode(String.self, forKey: .date)
        breakfast = try container.decodeIfPresent(CafeteriaDTO.self, forKey: .breakfast) ?? CafeteriaDTO()
        lunch = try container.decodeIfPresent(CafeteriaDTO.self, forKey: .lunch) ?? CafeteriaDTO()
        dinner = try container.decodeIfPresent(CafeteriaDTO.self, forKey: .dinner) ?? CafeteriaDTO()
        all = try container.decodeIfPresent(CafeteriaDTO.self, forKey: .all) ?? CafeteriaDTO()
    }
}


struct WeeklyMenuDTO: Codable {
    let campus: String
    let menuData: [DailyMenuDTO]
}
