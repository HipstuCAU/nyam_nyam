//
//  RunningStatus.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/03/10.
//

import Foundation

enum RunningStatus {
    case expired
    case running
    case ready
    case empty
    case suspended
    
    func getRunningStatus(of meal: Meal) -> RunningStatus {
        let now = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: now)
        let minute = calendar.component(.minute, from: now)

        let cafeteria = meal.cafeteria
        let mealTime = meal.mealTime
    
        if meal.status == .CloseOnWeekends {
            return .empty
        }
        switch cafeteria {
        case .chamseulgi:
            if mealTime == .breakfast {
                
            } else if mealTime == .lunch {
                
            } else if mealTime == .dinner {
                
            } else {
                return .running
            }
        case .blueMirA:
            if mealTime == .breakfast {
                
            } else if mealTime == .lunch {
                
            } else if mealTime == .dinner {
                
            } else {
                return .running
            }
        case .blueMirB:
            if mealTime == .breakfast {
                
            } else if mealTime == .lunch {
                
            } else if mealTime == .dinner {
                
            } else {
                return .running
            }
        case .student:
            if mealTime == .breakfast {
                
            } else if mealTime == .lunch {
                
            } else if mealTime == .dinner {
                
            } else {
                return .running
            }
        case .staff:
            if mealTime == .breakfast {
                
            } else if mealTime == .lunch {
                
            } else if mealTime == .dinner {
                
            } else {
                return .running
            }
        case .cauEats:
            if mealTime == .breakfast {
                
            } else if mealTime == .lunch {
                
            } else if mealTime == .dinner {
                
            } else {
                return .running
            }
        case .cauBurger:
            return .running
        case .ramen:
            return .running
        }
        return .suspended
    }
}
