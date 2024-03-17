//
//  HaksikState.swift
//  NyamNyam
//
//  Created by 박준홍 on 2024/01/15.
//

import Foundation
import ReactorKit

struct HaksikPresentableState {
    var mealPlans: [MealPlan]? = nil
    var userUniversityData: UserUniversity? = nil
    var universityInfo: UniversityInfo? = nil
    var isLoading: Bool = false
    var alertInfo: AlertInfo? = nil
    var selectedDate: Date? = nil
}
