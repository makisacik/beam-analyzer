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
        coordinator?.navigateToLogin()

    }

}
