//
//  Campus.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/02/28.
//

import Foundation

enum Campus: String {
    case seoul
    case ansung
    
    func mealsForAllDayByCampus() -> [MealsForDay] {
        if self == .seoul {
            return []
            // getMealsForWeeks(campus: Campus) -> [MealsForDate] 가 필요합니다.
        } else {
            return []
        }
    }
}
