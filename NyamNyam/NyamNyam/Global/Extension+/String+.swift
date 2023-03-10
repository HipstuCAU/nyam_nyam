//
//  String+.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/02/27.
//

import Foundation

extension String {
    func formatStringToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.date(from: self)
    }
    
    func formatStringToFullDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: self)
    }
}
