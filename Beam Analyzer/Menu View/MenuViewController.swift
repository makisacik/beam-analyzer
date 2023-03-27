//
//  MenuViewController.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 20.03.2023.
//

import UIKit

final class MenuViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Menu"
        navigationItem.hidesBackButton = true
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupViews() {
        let messageButton = UIBarButtonItem(image: UIImage(systemName: "message"), style: .plain, target: self, action: #selector(messageButtonTapped))
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(settingsButtonTapped))
        messageButton.tintColor = .label
        settingsButton.tintColor = .label
        
        navigationItem.rightBarButtonItem = messageButton
        navigationItem.leftBarButtonItem = settingsButton
        
        view.backgroundColor = .systemBackground
    }
    
    @objc func messageButtonTapped() {
        coordinator?.navigateToMessagingTabBar()
    }
    
    @objc func settingsButtonTapped() {
        coordinator?.navigateToSettings()
    }

}
