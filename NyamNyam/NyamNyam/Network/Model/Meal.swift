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

enum Cafeteria {
    case chamseulgi
    case blueMirA
    case blueMirB
    case student
    case staff
}

struct Meal: Hashable {
    let mealTime: MealTime
    let type: String
    let cafeteria: Cafeteria
    let price: String
    let menu: String
    let date: Date
}
