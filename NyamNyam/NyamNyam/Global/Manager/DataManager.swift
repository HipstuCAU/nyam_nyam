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
    
    func getMealsOfDay(_ strData: String, _ campus: String) -> [Meal] {
        let dictData = stringToDict(strData)
        var meals: [Meal] = []
        if  let dayDict = dictData?[campus] as? [String: Any] {
            for i in 0..<dayDict.count {
                let dayIndex = dayDict.index(dayDict.startIndex, offsetBy: i)
                let day = dayDict.keys[dayIndex]
                if let mealTimeDict = dayDict[day] as? [String: Any] {
                    for j in 0..<mealTimeDict.count {
                        let mealTimeIndex = mealTimeDict.index(mealTimeDict.startIndex, offsetBy: j)
                        let mealTime = mealTimeDict.keys[mealTimeIndex]
                        if let cafeteriaDict = mealTimeDict[mealTime] as? [String: Any] {
                            for k in 0..<cafeteriaDict.count {
                                let cafeteriaIndex = cafeteriaDict.index(cafeteriaDict.startIndex, offsetBy: k)
                                let cafeteria = cafeteriaDict.keys[cafeteriaIndex]
                                if let mealTypeDict = cafeteriaDict[cafeteria] as? [String: Any] {
                                    for l in 0..<mealTypeDict.count {
                                        let mealTypeIndex = mealTypeDict.index(mealTypeDict.startIndex, offsetBy: l)
                                        let mealType = mealTypeDict.keys[mealTypeIndex]
                                        if let menuDict = mealTypeDict[mealType] as? [String: Any],
                                           let menu = menuDict["menu"] as? String,
                                           let price = menuDict["price"] as? String {
                                            meals.append(Meal(mealTime: getMealTime(mealTime), type: getMealType(mealType), cafeteria: getCafeteria(cafeteria), price: getPrice(price), menu: getMenu(menu), date: day.formatStringToDate() ?? Date()))
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return meals
    }

}

private extension DataManager {
    func getMealTime(_ mealTime: String) -> MealTime  {
        switch mealTime {
        case "0":
            return .breakfast
        case "1":
            return .lunch
        case "2":
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
