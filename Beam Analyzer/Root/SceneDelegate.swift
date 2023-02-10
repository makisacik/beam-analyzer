//
//  SceneDelegate.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 5.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let appCoordinator = AppCoordinator()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        appCoordinator.startCoordinator()
        window = UIWindow(windowScene: scene)
        window?.windowScene = scene
        window?.rootViewController = appCoordinator.navigationController
        window?.makeKeyAndVisible()
    }

}
