//
//  SettingViewModel.swift
//  NyamNyam
//
//  Created by 한택환 on 2023/03/13.
//

import Foundation

final class SettingViewModel {
    var currentCampus: Observable<Campus>
    
    init() {
        self.currentCampus = Observable(Campus(rawValue: UserDefaults.standard.campus) ?? .seoul)
    }
}
