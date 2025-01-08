//
//  SceneDelegate.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController(rootViewController: MainViewController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // 앱이 백그라운드로 이동하거나 종료될 때 호출
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // 앱이 활성 상태로 전환될 때 호출
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // 앱이 비활성 상태로 전환될 때 호출
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // 앱이 포그라운드로 복귀할 때 호출
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // 앱이 백그라운드로 이동할 때 호출
    }
}


