//
//  UserDefaults+.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/03/01.
//

import Foundation

extension UserDefaults {
    enum Key: String {
        case isFirstLaunch
        case campus
    }
    
    var isFirstLaunch: Bool {
        get { return bool(forKey: Key.isFirstLaunch.rawValue) }
        set { set(newValue, forKey: Key.isFirstLaunch.rawValue) }
    }
    
    var campus: String {
        get { return string(forKey: Key.campus.rawValue) ?? Campus.seoul.rawValue }
        set { set(newValue, forKey: Key.campus.rawValue) }
    }
}
