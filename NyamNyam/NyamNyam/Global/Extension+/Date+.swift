//
//  Date+.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/02/27.
//

import Foundation

extension Date {
    
    func makeKoreanDate() -> Date {
        let ret = Calendar.current.date(byAdding: .hour, value: 9, to: self)
        return ret ?? Date()
    }
    
    func makeKoreanDateReverse() -> Date {
        let ret = Calendar.current.date(byAdding: .hour, value: -9, to: self)
        return ret ?? Date()
    }
    
    func isToday() -> Bool {
        guard let today = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date()) else { return false }
        guard let date = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: self) else { return false }
        if today == date { return true }
        return false
    }
    
    func toTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
    
    static func prepareDateList() -> [Date] {
        var dateList = [Date]()
        (0..<7).forEach {
            dateList.append(Date().convertDay(for: $0))
        }
        return dateList
    }
    
    func toFullString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: self)
    }
    
    func toDayString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: self)
    }
    
    func toDayOfWeekString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: self)
    }
    
    func convertDay(for day: Int) -> Date {
        var currentDate: Date { Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date()) ?? Date() }
        let ret = Calendar.current.date(byAdding: .day, value: day, to: currentDate)
        return ret ?? Date()
    }
    
    static func SetTodayDateOf(hour: Int, minutes: Int) -> Date {
        var ret: Date { Calendar.current.date(bySettingHour: hour, minute: minutes, second: 0, of: Date()) ?? Date() }
        return ret
    }
}
