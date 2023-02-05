//
//  SceneDelegate.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 5.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: scene)
        appCoordinator = AppCoordinator(window: window)

        appCoordinator?.start()
    }

}

