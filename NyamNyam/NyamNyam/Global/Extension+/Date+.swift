//
//  Date+.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/02/27.
//

import Foundation

extension Date {
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
}
