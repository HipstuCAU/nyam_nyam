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
    var indexOfCafetera: Observable<Int>
    var pickedCafeteria: Observable<Cafeteria>
    
    
    init() {
        self.currentCampus = Observable(Campus(rawValue: UserDefaults.standard.campus) ?? .seoul)
        
        self.indexOfDate = Observable(getIndexOfDate())
        self.dateList = prepareDateList()
        self.pickedDate = Observable(dateList[indexOfDate.value])
        
        self.cafeteriaList = userCafeterias // TODO: - UserDefault로 수정 필요
        self.indexOfCafetera = Observable(0)
        self.pickedCafeteria = Observable(cafeteriaList[indexOfCafetera.value])
        
        func getIndexOfDate() -> Int {
            // 오늘 Date를 기준으로 계산 필요 (startDayOfWeek로부터 얼마나 떨어져 있는지)
            return 0
        }
        
        func prepareDateList() -> [Date] {
            // 오늘 날짜의 start day of week를 계산해서 7일 동안의 date 배열
            return ["23.02.28".formatStringToDate() ?? Date(),
                    "23.03.01".formatStringToDate() ?? Date(),
                    "23.03.02".formatStringToDate() ?? Date(),
                    "23.03.03".formatStringToDate() ?? Date(),
                    "23.03.04".formatStringToDate() ?? Date(),
                    "23.03.05".formatStringToDate() ?? Date(),
                    "23.03.06".formatStringToDate() ?? Date(),]
        }
    }
    
}
