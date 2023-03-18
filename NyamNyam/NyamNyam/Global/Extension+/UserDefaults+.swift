//
//  UserDefaults+.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/03/01.
//

import Foundation

extension UserDefaults {
    enum Key: String {
        case isNotFirstLaunch
        case campus
        case seoulCafeteria
        case ansungCafeteria
        case lastUploadDate
    }
    
    var isNotFirstLaunch: Bool {
        get { return bool(forKey: Key.isNotFirstLaunch.rawValue) }
        set { set(newValue, forKey: Key.isNotFirstLaunch.rawValue) }
    }
    
    var campus: String {
        get { return string(forKey: Key.campus.rawValue) ?? Campus.seoul.rawValue }
        set { set(newValue, forKey: Key.campus.rawValue) }
    }
    
    var seoulCafeteria: [String] {
        get { return array(forKey: Key.seoulCafeteria.rawValue) as? [String] ?? [] }
        set { set(newValue, forKey: Key.seoulCafeteria.rawValue) }
    }
    
    var ansungCafeteria: [String] {
        get { return array(forKey: Key.ansungCafeteria.rawValue) as? [String] ?? [] }
        set { set(newValue, forKey: Key.ansungCafeteria.rawValue) }
    }
    
    var lastUploadDate: String {
        get { return string(forKey: Key.isNotFirstLaunch.rawValue) ?? Date().toFullTimeString() }
        set { set(newValue, forKey: Key.isNotFirstLaunch.rawValue)}
    }
}
