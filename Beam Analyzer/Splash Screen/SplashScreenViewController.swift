//
//  SplashScreenViewController.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 5.02.2023.
//

import UIKit

final class SplashScreenViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if AuthService.shared.isUserSignedIn() {
                self.coordinator?.navigateToMenu()
            } else {
                self.coordinator?.navigateToLogin()
            }
        }

    }

}
