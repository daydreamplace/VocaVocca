//
//  SceneDelegate.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
            guard let windowScene = (scene as? UIWindowScene) else { return }

            window = UIWindow(windowScene: windowScene)

        let firstViewController = UINavigationController(rootViewController: VocaMainViewController())
        let secondViewController = UINavigationController(rootViewController: LearningViewController())
        let thirdViewController = UINavigationController(rootViewController: RecordResultViewController())
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([firstViewController, secondViewController, thirdViewController], animated: true)
        
        if let items = tabBarController.tabBar.items {
            items[0].image = UIImage(systemName: "book")
            items[0].title = "단어장"
            items[1].image = UIImage(systemName: "graduationcap")
            items[1].title = "학습"
            items[2].image = UIImage(systemName: "list.bullet")
            items[2].title = "기록"
        }
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        }
}


