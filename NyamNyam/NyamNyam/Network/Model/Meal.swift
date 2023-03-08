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
}

enum MealType {
    case normal
    case special
}

struct Meal: Hashable {
    let mealTime: MealTime
    let type: MealType
    let cafeteria: Cafeteria
    let price: String
    let menu: String
    let date: Date
}
