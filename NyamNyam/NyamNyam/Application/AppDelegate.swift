//
//  AppDelegate.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/02/27.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setOptionsWithFirstLaunch()
        
        func setOptionsWithFirstLaunch() {
            let isFirstLaunch = !UserDefaults.standard.isFirstLaunch
            
            if isFirstLaunch {
                #if DEBUG
                print("First Launch")
                #endif
                UserDefaults.standard.campus = Campus.seoul.rawValue
                UserDefaults.standard.seoulCafeteria = [Cafeteria.chamseulgi.rawValue,
                                                   Cafeteria.blueMirA.rawValue,
                                                   Cafeteria.blueMirB.rawValue,
                                                   Cafeteria.student.rawValue,
                                                        Cafeteria.staff.rawValue]
                UserDefaults.standard.ansungCafeteria = [Cafeteria.cauEats.rawValue,
                                                         Cafeteria.cauBurger.rawValue,
                                                         Cafeteria.ramen.rawValue]
                // MARK: 이곳에 첫 Launch시 실행할 작업들이 들어갑니다.
                UserDefaults.standard.isFirstLaunch = true
            }
        }
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

