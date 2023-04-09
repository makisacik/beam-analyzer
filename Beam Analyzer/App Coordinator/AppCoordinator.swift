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
        let menuVC = MenuViewController()
        menuVC.coordinator = self
        navigationController?.pushViewController(menuVC, animated: true)
    }
    
    func navigateToSettings() {
        let settingsVC = SettingsViewController()
        settingsVC.coordinator = self
        navigationController?.pushViewController(settingsVC, animated: true)
    }

    func navigateToMessagingTabBar() {
        let messagingTabBarVC = MessagingTabBarController()
        messagingTabBarVC.coordinator = self
        navigationController?.pushViewController(messagingTabBarVC, animated: true)
    }
    
    func navigateToChat() {
        let chatVC = ChatViewController()
        chatVC.coordinator = self
        navigationController?.pushViewController(chatVC, animated: true)
    }

}
