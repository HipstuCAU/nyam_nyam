//
//  DataManager.swift
//  NyamNyam
//
//  Created by 한택환 on 2023/03/09.
//

import Foundation

final class DataManager {
    static func stringToDict() -> [String: Any]? {
        let strData = JsonManager.shared.jsonToString()
        if let strData = strData?.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: strData, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    static func getMealsForDay(_ campus: String) -> [Meal] {
        let dictData = stringToDict()
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
                                           let price = menuDict["price"] as? String,
                                           let time = menuDict["time"] as? String {
                                            //TODO: 따로 status 검사하는 함수 넣어 변경 예정
                                            let times = getTime(time, day)
                                            meals.append(Meal(mealTime: getMealTime(mealTime, cafeteria), type: getMealType(mealType, campus), cafeteria: getCafeteria(cafeteria), price: getPrice(price), menu: getMenu(menu), date: Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: day.formatStringToDate() ?? Date()) ?? Date(), status: getStatus(menu), startDate: times?[0], endDate: times?[1]))
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
    static func getMealsForWeeks(_ campus: Campus) -> [MealsForDay] {
        let campusString: String
        campusString = campus == .seoul ? "0" : "1"
        var mealsForWeek: [MealsForDay] = []
        let mealsForDay = getMealsForDay(campusString)
        let weeklyDate = Date.prepareDateList()
        for dayIndex in weeklyDate.indices {
            var meals: Set<Meal> = []
            for meal in mealsForDay {
                if weeklyDate[dayIndex] == meal.date && meal.menu != [""] {
                    meals.insert(meal)
                }
            }
            if meals != [] {
                mealsForWeek.append(MealsForDay(date: weeklyDate[dayIndex], meals: meals))
            }
        }
        return mealsForWeek
    }
    
}

private extension DataManager {
    static func getMealTime(_ mealTime: String, _ cafeteria: String) -> MealTime  {
        if cafeteria == "(안성)카우버거" {
            return .cauburger
        } else if cafeteria == "(안성)라면" {
            return .ramen
        } else {
            switch mealTime {
            case "0":
                return .breakfast
            case "1":
                return .lunch
            case "2":
                return .dinner
            default:
                return .breakfast
            }
        }
    }
    
    static func getMealType(_ mealType: String, _ campus: String) -> MealType {
        let mealTypeTuple = (mealType, campus)
        switch mealTypeTuple {
        case ("중식(특식)", "0"):
            return .special
        default:
            return .normal
        }
    }
    
    static func getCafeteria(_ cafeteria: String) -> Cafeteria {
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
        case "University Club(102관11층)":
            return .universityClub
        case "카우잇츠(cau eats)":
            return .cauEats
        case "(안성)카우버거":
            return .cauBurger
        case "(안성)라면":
            return .ramen
        default:
            return .none
        }
    }
    
    static func getPrice(_ price: String) -> String {
        return price.components(separatedBy: [","," ","원"]).joined()
        
    }
    
    static func getMenu(_ menu: String) -> [String] {
        return menu.components(separatedBy: "|")
    }
    
    static func getStatus(_ menu: String) -> Status {
        switch menu {
        case "주말운영없음":
            return .CloseOnWeekends
        default :
            return .normal
        }
    }
    
    static func getTime(_ time: String, _ date: String) -> [Date]? {
        let strTimes = time.components(separatedBy: "~")
        if strTimes.count < 2 {
            return nil
        }
        var times: [Date] = []
        for time in strTimes {
            times.append(String("\(date) \(time):00").formatStringToFullDate() ?? Date())
        }
        return times
    }
}

