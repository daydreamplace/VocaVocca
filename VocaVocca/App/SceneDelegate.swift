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
        let navigationController = UINavigationController(rootViewController: VocaMainViewController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}


