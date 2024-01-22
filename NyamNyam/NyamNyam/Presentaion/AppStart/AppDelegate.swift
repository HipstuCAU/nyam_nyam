//
//  AppDelegate.swift
//  NyamNyam
//
//  Created by Sdaq on 2024/01/08.
//

import UIKit
import RIBs
import Firebase

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    private var launchRouter: LaunchRouting?

    var appComponent: AppComponent = AppComponent()
    
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        FirebaseApp.configure()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        let launchRouter = RootBuilder(
            dependency: appComponent
        ).build()
        
        self.launchRouter = launchRouter

        launchRouter.launch(from: window)

        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("AppDelegate: applicationDidBecomeActive")
        appComponent.applicationDidBecomeActiveRelay.accept(())
    }
}
