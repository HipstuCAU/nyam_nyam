//
//  HaksikState.swift
//  NyamNyam
//
//  Created by 박준홍 on 2024/01/15.
//

import Foundation
import ReactorKit

struct HaksikPresentableState {
    // Store
    var mealPlans: [MealPlan]? = nil
    var userUniversityData: UserUniversity? = nil
    var universityInfo: UniversityInfo? = nil
    
    // UI
    var isLoading: Bool = false
    var alertInfo: AlertInfo? = nil
    var campusTitle: String? = nil
    var availableDates: [Date]? = nil
    var cafeteriaInfos: [CafeteriaInfo]? = nil
    
    var selectedDate: Date? = nil
    var selectedCafeteria: CafeteriaInfo? = nil
}

