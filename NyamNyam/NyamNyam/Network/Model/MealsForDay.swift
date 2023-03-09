//
//  MealsForDay.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/02/27.
//

import Foundation

struct MealsForDay: Hashable {
    let date: Date
    let meals: Set<Meal>
}
