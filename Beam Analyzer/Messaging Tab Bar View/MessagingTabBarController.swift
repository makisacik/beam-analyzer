//
//  MessagingTabBarController.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 26.03.2023.
//

import UIKit

class MessagingTabBarController: UITabBarController {
    
    weak var coordinator: AppCoordinator?
    private let conversationsViewController = ConversationsViewController()
    private let searchUsersViewController = SearchUsersViewController()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        conversationsViewController.coordinator = coordinator
        searchUsersViewController.coordinator = coordinator
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Messaging"
        conversationsViewController.tabBarItem = UITabBarItem(title: "Conversations", image: UIImage(systemName: "message"), tag: 0)
        searchUsersViewController.tabBarItem = UITabBarItem(title: "Search Users", image: UIImage(systemName: "person"), tag: 1)
        viewControllers = [conversationsViewController, searchUsersViewController]
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
}
