//
//  Meal.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/02/28.
//

import Foundation

enum MealTime {
    case breakfast
    case lunch
    case dinner
    case allDay
}

enum Cafeteria: String {
    case chamseulgi
    case blueMirA
    case blueMirB
    case student
    case staff
    case cauEats
    case cauBurger
    case ramen
}

enum MealType {
    case normal
    case special
}

enum Status {
    case normal
    case CloseOnWeekends
}

struct Meal: Hashable, Comparable {
    let mealTime: MealTime
    let type: MealType
    let cafeteria: Cafeteria
    let price: String
    let menu: [String]
    let date: Date
    let status: Status
    
    static func < (lhs: Meal, rhs: Meal) -> Bool {
        if lhs.type == rhs.type {
            if lhs.price == rhs.price {
                if lhs.menu.first ?? "" < rhs.menu.first ?? "" { return true }
                else { return false }
            } else {
                if lhs.price < rhs.price { return true }
                else { return false }
            }
        } else {
            if rhs.type == .special { return true }
            else { return false }
        }
    }
}
