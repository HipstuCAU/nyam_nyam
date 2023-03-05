//
//  Date+.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/02/27.
//

import Foundation

extension Date {
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
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: self)
    }
    
    func convertDay(for day: Int) -> Date {
        let ret = Calendar.current.date(byAdding: .day, value: day, to: self)
        return ret ?? Date()
    }
}
