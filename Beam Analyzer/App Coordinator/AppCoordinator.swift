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
        loginVC.coordinator = self
        navigationController?.pushViewController(loginVC, animated: true)
    }

    func navigateToRegister() {
        let registerVC = RegisterViewController()
        registerVC.coordinator = self
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    func navigateToMenu() {
        
    }

}
