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
    var pickedDate: Observable<Date>
    
    // MARK: - cafeteria picker 값
    var seoulCafeteriaList: [Cafeteria]
    var ansungCafeteriaList: [Cafeteria]
    var indexOfCafeteria: Observable<Int>
    var pickedCafeteria: Observable<Cafeteria>
    
    
    init() {
        self.currentCampus = Observable(Campus(rawValue: UserDefaults.standard.campus) ?? .seoul)
        
        self.indexOfDate = Observable(0)
        self.dateList = prepareDateList()
        self.pickedDate = Observable(dateList[indexOfDate.value])
        
        self.seoulCafeteriaList = UserDefaults.standard.seoulCafeteria.map {
            return Cafeteria(rawValue: $0) ?? Cafeteria.chamseulgi
        }
        
        self.ansungCafeteriaList = UserDefaults.standard.ansungCafeteria.map {
            return Cafeteria(rawValue: $0) ?? Cafeteria.cauEats
        }
        
        self.indexOfCafeteria = Observable(0)
        self.pickedCafeteria = Observable(seoulCafeteriaList[indexOfCafeteria.value])
        
        func prepareDateList() -> [Date] {
            var dateList = [Date]()
            for idx in 0 ..< 7 {
                dateList.append(Date().convertDay(for: idx))
            }
            return dateList
        }
    }
    
}
