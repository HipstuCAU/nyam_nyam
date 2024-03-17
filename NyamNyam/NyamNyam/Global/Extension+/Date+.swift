//
//  Date+.swift
//  NyamNyam
//
//  Created by 박준홍 on 2023/02/27.
//

import Foundation

extension Date {
    // 날짜를 뽑는 메소드 ex) 2024.03.08이면 "8" 반환
    func extractDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: self)
    }

    // 요일 축약형 (한국)을 뽑는 메소드 ex) 2024.03.08.Fri이면 "금" 반환
    func extractWeekday() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: self)
    }
    
    // 날짜 (day)를 더하는 메소드
    func adding(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self) ?? Date()
    }

    
    func makeKoreanDate() -> Date {
        let ret = self.addingTimeInterval(TimeInterval(TimeZone.autoupdatingCurrent.secondsFromGMT(for: self)))
        return ret
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
    
    func isPastDay() -> Bool {
        guard let today = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date()) else { return false }
        guard let date = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: self) else { return false }
        if today > date { return true }
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
    
    func toStringWithTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
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
