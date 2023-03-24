//
//  SceneDelegate.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/02/27.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        var isUpdated = false
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        let storyboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
        let defaultWindow = storyboard.instantiateViewController(withIdentifier: "LaunchScreenViewController")
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = defaultWindow
        AlertManager.addAlert(defaultWindow,
                              key: "netWorkNotConnectedInLaunching",
                              title: "인터넷이 연결되지 않았어요",
                              message: "인터넷이 연결되어야 식단을 최신화 할 수 있어요") { }
        
        AlertManager.addAlert(defaultWindow,
                              key: "networkDelayedInLaunching",
                              title: "식단을 받아오는 도중 문제가 발생했어요",
                              message: "인터넷 연결을 확인해주세요") { }
        
        FBManager.shared.getMealJson() {
            isUpdated = true
            let viewController = HomeViewController()
            let navigationController = UINavigationController(rootViewController: viewController)
            AlertManager.addAlert(viewController,
                                  key: "netWorkNotConnectedInHome",
                                  title: "인터넷이 연결되지 않았어요",
                                  message: "인터넷이 연결되어야 식단을 최신화 할 수 있어요") {
            }
            AlertManager.addAlert(viewController,
                                  key: "netWorkDelayedInHome",
                                  title: "식단을 받아오는 도중 문제가 발생했어요",
                                  message: "인터넷 연결을 확인해주세요") {
            }
            self.window?.rootViewController = navigationController
        }
        if Reachability.networkConnected() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                if !isUpdated {
                    AlertManager.performAlertAction(of: "networkDelayedInLaunching")
                }
            }
        } else {
            AlertManager.performAlertAction(of: "netWorkNotConnectedInLaunching")
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

