//
//  MessagingTabBarController.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 26.03.2023.
//

import UIKit

class MessagingTabBarController: UITabBarController {
    
    weak var coordinator: AppCoordinator?
    private var deflectionCalculation: DeflectionCalculation?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    init(calculation: DeflectionCalculation?) {
        self.deflectionCalculation = calculation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createTabBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Messaging"
        
    }
    
    private func createTabBar() {
        let searchUsersVC: SearchUsersViewController
        let conversationsVC: ConversationsViewController

        if let deflectionCalculation {
            searchUsersVC = SearchUsersViewController(calculation: deflectionCalculation)
            conversationsVC = ConversationsViewController(deflectionCalculation: deflectionCalculation)
        } else {
            searchUsersVC = SearchUsersViewController()
            conversationsVC = ConversationsViewController()
        }

        conversationsVC.coordinator = coordinator
        searchUsersVC.coordinator = coordinator

        conversationsVC.tabBarItem = UITabBarItem(title: "Conversations", image: UIImage(systemName: "message"), tag: 0)
        searchUsersVC.tabBarItem = UITabBarItem(title: "Search Users", image: UIImage(systemName: "person"), tag: 1)

        viewControllers = [conversationsVC, searchUsersVC]

    }
    
}
