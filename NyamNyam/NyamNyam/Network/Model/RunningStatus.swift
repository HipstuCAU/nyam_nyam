//
//  RunningStatus.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/03/10.
//

import Foundation

enum RunningStatus: String {
    case expired = "운영종료"
    case running = "운영중"
    case ready = "준비중"
    case notInOperation = "미운영"
    
    static func getRunningStatus(of meals: [Meal], at cafeteria: Cafeteria) -> RunningStatus? {
        let currentDate = Date().makeKoreanDate()
        
        if cafeteria != .cauBurger && cafeteria != .ramen {
            guard let firstMeal = meals.sorted(by: <).first, let start = firstMeal.startDate, let end = firstMeal.endDate else { return nil }
            
            if currentDate >= start && currentDate < end { return .running }
            else if currentDate < start { return .ready }
            else { return .expired }
            
        } else if cafeteria == .cauBurger {
            let start = Date.SetTodayDateOf(hour: 9, minutes: 30).makeKoreanDate()
            let end = Date.SetTodayDateOf(hour: 18, minutes: 30).makeKoreanDate()
            if currentDate >= start && currentDate < end { return .running }
            else if currentDate < start { return .ready }
            else { return .expired }
            
        } else {
            
            let start = Date.SetTodayDateOf(hour: 6, minutes: 0).makeKoreanDate()
            let end = Date.SetTodayDateOf(hour: 23, minutes: 0).makeKoreanDate()
            if currentDate >= start && currentDate < end { return .running }
            else if currentDate < start { return .ready }
            else { return .expired }
            
        }
    }
}
