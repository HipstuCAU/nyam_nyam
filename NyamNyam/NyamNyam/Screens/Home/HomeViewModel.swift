//
//  HomeViewModel.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/02/27.
//

import UIKit

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
        self.dateList = Date.prepareDateList()
        
        self.seoulCafeteriaList = UserDefaults.standard.seoulCafeteria.map {
            guard let cafeteria = Cafeteria(rawValue: $0) else { fatalError() }
            return cafeteria
        }
        
        self.ansungCafeteriaList = UserDefaults.standard.ansungCafeteria.map {
            guard let cafeteria = Cafeteria(rawValue: $0) else { fatalError() }
            return cafeteria
        }
        
        self.indexOfCafeteria = Observable(0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleSeoulCafeteriaChanged), name: UserDefaults.didChangeNotification, object: UserDefaults.standard)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleAnsungCafeteriaChanged), name: UserDefaults.didChangeNotification, object: UserDefaults.standard)
        
    }
    
    
    @objc func handleSeoulCafeteriaChanged() {
        self.seoulCafeteriaList = UserDefaults.standard.seoulCafeteria.map {
            guard let cafeteria = Cafeteria(rawValue: $0) else { fatalError() }
            return cafeteria
        }
    }
    
    @objc func handleAnsungCafeteriaChanged() {
        self.ansungCafeteriaList = UserDefaults.standard.ansungCafeteria.map {
            guard let cafeteria = Cafeteria(rawValue: $0) else { fatalError() }
            return cafeteria
        }
    }
    
}
