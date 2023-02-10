//
//  AppCoordinator.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 5.02.2023.
//

import UIKit

final class AppCoordinator {

    var navigationController: UINavigationController?

    func startCoordinator() {
        let splashScreenVC = SplashScreenViewController(nibName: String(describing: SplashScreenViewController.self), bundle: nil)
        splashScreenVC.coordinator = self
        navigationController = UINavigationController(rootViewController: splashScreenVC)
    }

    func navigateToLogin() {
        let loginVC = LoginViewController()
        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.pushViewController(loginVC, animated: true)
    }

}
