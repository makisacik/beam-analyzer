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
    
    func navigateToChat(with receiverUser: User) {
        let chatVC = ChatViewController(receiverUser: receiverUser)
        chatVC.coordinator = self
        navigationController?.pushViewController(chatVC, animated: true)
    }
    
    func navigateToInputs(calculationType: CalculationType) {
        let calculationVC = CalculationInputsViewController(calculationType: calculationType)
        calculationVC.coordinator = self
        navigationController?.pushViewController(calculationVC, animated: true)
    }
    
    func navigateToMockCalculationResults() {
        let calculationResultsVC = MockCalculationResultsViewController()
        calculationResultsVC.coordinator = self
        navigationController?.pushViewController(calculationResultsVC, animated: true)
    }
    
    func navigateToCalculationResult(deflectionCalculation: DeflectionCalculation, savedCalculation: CalculationEntity? = nil) {
        let calculationResultVC = CalculationResultViewController(deflectionCalculation: deflectionCalculation)
        calculationResultVC.coordinator = self
        
        if let savedCalculation {
            calculationResultVC.savedCalculation = savedCalculation
        }
        
        navigationController?.pushViewController(calculationResultVC, animated: true)
    }
    
    func navigateToSavedCalculations() {
        let savedCalculationsVC = SavedCalculationsViewController()
        savedCalculationsVC.coordinator = self
        navigationController?.pushViewController(savedCalculationsVC, animated: true)
    }
    
    func navigateToCalculationMenu() {
        let calcMenuVC = CalculationsMenuViewController()
        calcMenuVC.coordinator = self
        navigationController?.pushViewController(calcMenuVC, animated: true)
    }
    
    func navigateToChangePassword() {
        let changePasswordVC = ChangePasswordViewController()
        navigationController?.pushViewController(changePasswordVC, animated: true)
    }
}
