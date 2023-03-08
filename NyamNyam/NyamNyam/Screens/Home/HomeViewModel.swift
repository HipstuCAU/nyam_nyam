//
//  HomeViewModel.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/02/27.
//

import Foundation

final class HomeViewModel {
    var currentCampus: Observable<Campus>
    let seoulMeals: [MealsForDay] = Campus.seoul.mealsForAllDayByCampus()
    let ansungMeals: [MealsForDay] = Campus.ansung.mealsForAllDayByCampus()
    
    // MARK: - date picker 값
    var dateList: [Date]
    var indexOfDate: Observable<Int>
    
    // MARK: - cafeteria picker 값
    var seoulCafeteriaList: [Cafeteria]
    var ansungCafeteriaList: [Cafeteria]
    var indexOfCafeteria: Observable<Int>
    
    
    init() {
        self.currentCampus = Observable(Campus(rawValue: UserDefaults.standard.campus) ?? .seoul)
        
        self.indexOfDate = Observable(0)
        self.dateList = prepareDateList()
        
        self.seoulCafeteriaList = UserDefaults.standard.seoulCafeteria.map {
            guard let cafeteria = Cafeteria(rawValue: $0) else { fatalError() }
            return cafeteria
        }
        
        self.ansungCafeteriaList = UserDefaults.standard.ansungCafeteria.map {
            guard let cafeteria = Cafeteria(rawValue: $0) else { fatalError() }
            return cafeteria
        }
        
        self.indexOfCafeteria = Observable(0)
        
        func prepareDateList() -> [Date] {
            var dateList = [Date]()
            (0..<7).forEach {
                dateList.append(Date().convertDay(for: $0))
            }
            return dateList
        }
    }
    
}
