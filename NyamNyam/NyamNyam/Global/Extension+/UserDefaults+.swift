//
//  UserDefaults+.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/03/01.
//

import Foundation

extension UserDefaults {
    enum Key: String {
        case lastUpdate
    }
    
    var lastUpdate: String? {
        get { return string(forKey: Key.lastUpdate.rawValue) }
        set { set(newValue, forKey: Key.lastUpdate.rawValue) }
    }
}
