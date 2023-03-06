//
//  HomeViewModel.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/02/27.
//

import Foundation

// TODO: - 해당 배열은 추후 UserDefault에 저장되어야 합니다.
var userCafeterias: [Cafeteria] = [.chamseulgi, .blueMirA, .blueMirB, .student, .staff]


final class HomeViewModel {
    var currentCampus: Observable<Campus>
    let seoulMeals: [MealsForDay] = Campus.seoul.mealsForAllDayByCampus()
    let ansungMeals: [MealsForDay] = Campus.ansung.mealsForAllDayByCampus()
    
    // MARK: - date picker 값
    var dateList: [Date]
    var indexOfDate: Observable<Int>
    var pickedDate: Observable<Date>
    
    // MARK: - cafeteria picker 값
    var cafeteriaList: [Cafeteria]
    var indexOfCafeteria: Observable<Int>
    var pickedCafeteria: Observable<Cafeteria>
    
    
    init() {
        self.currentCampus = Observable(Campus(rawValue: UserDefaults.standard.campus) ?? .seoul)
        
        self.indexOfDate = Observable(0)
        self.dateList = prepareDateList()
        self.pickedDate = Observable(dateList[indexOfDate.value])
        
        self.cafeteriaList = userCafeterias // TODO: - UserDefault로 수정 필요
        self.indexOfCafeteria = Observable(0)
        self.pickedCafeteria = Observable(cafeteriaList[indexOfCafeteria.value])
        
        func prepareDateList() -> [Date] {
            var dateList = [Date]()
            for idx in 0 ..< 7 {
                dateList.append(Date().convertDay(for: idx))
            }
            return dateList
        }
    }
    
}
