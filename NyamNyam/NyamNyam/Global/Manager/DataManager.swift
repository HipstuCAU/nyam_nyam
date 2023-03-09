//
//  DataManager.swift
//  NyamNyam
//
//  Created by 한택환 on 2023/03/09.
//

import Foundation

final class DataManager {
    func stringToDict(_ strData: String) -> [String: Any]? {
        if let strData = strData.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: strData, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

private extension DataManager {
    func getMealTime(_ mealTime: String) -> MealTime  {
        switch mealTime {
        case "0":
            return .breakfast
        case"1":
            return .lunch
        case"2":
            return .dinner
        default:
            return .allDay
        }
    }

    func getMealType(_ mealType: String) -> MealType {
        switch mealType {
        case "중식(특식)":
            return .special
        default:
            return .normal
        }
    }

    func getCafeteria(_ cafeteria: String) -> Cafeteria {
        switch cafeteria {
        case "생활관식당(블루미르308관)":
            return .blueMirA
        case "참슬기식당(310관 B4층)":
            return .chamseulgi
        case "생활관식당(블루미르309관)":
            return .blueMirB
        case "학생식당(303관B1층)":
            return .student
        case "교직원식당(303관B1층)":
            return .staff
        case "카우잇츠(cau eats)":
            return .cauEats
        case "(안성)카우버거":
            return .cauBurger
        case "(안성)라면":
            return .ramen
        default:
            return .blueMirA
        }
    }
    
    func getPrice(_ price: String) -> String {
        return price.components(separatedBy: [","," ","원"]).joined()
        
    }

    func getMenu(_ menu: String) -> [String] {
        return menu.components(separatedBy: "|")
    }
}
