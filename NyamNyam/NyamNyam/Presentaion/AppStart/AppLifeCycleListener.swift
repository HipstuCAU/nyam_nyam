//
//  AppLifeCycleListener.swift
//  NyamNyam
//
//  Created by Sdaq on 2024/01/11.
//

import Foundation

protocol AppLifecycleListener: AnyObject {
    func appDidBecomeActive()
    func appDidEnterBackground()
}
