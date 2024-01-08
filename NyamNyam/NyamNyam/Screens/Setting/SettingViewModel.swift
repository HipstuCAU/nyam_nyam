//
//  SettingViewModel.swift
//  NyamNyam
//
//  Created by 한택환 on 2023/03/13.
//

import Foundation

final class SettingViewModel {
    var currentCampus: CustomObservable<Campus>
    
    init() {
        self.currentCampus = CustomObservable(Campus(rawValue: UserDefaults.standard.campus) ?? .seoul)
    }
}
