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
    let seoulMeals: [MealsForDay] = Campus.seoul.mealsForAllDayByCampus()
    let ansungMeals: [MealsForDay] = Campus.ansung.mealsForAllDayByCampus()
    
    // TODO: - date picker 값
    var indexOfDate: Int {
        return 0 // 오늘 Date를 기준으로 계산 필요 (startDayOfWeek로부터 얼마나 떨어져 있는지)
    }
    var dateList: [Date] {
        return [] // 오늘 날짜의 start day of week를 계산해서 7일 동안의 date 배열
    }
    
    // TODO: - cafeteria picker 값
    var indexOfCafetera: Int = 0
    // userCafeterias는 Cafeteria가 유저 선택에 따라 차례대로 들어간 값입니다.
    // 해당 값은 userDefault에 저장됩니다.
    var currentCafeteria: Cafeteria {
        userCafeterias[indexOfCafetera] // UserDefault의 Cafeterias 순서
    }
    
}
