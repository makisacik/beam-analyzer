//
//  ShareCalculationViewController.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 9.05.2023.
//

import UIKit
import SnapKit

final class ShareCalculationViewController: UIViewController {
    
    private let conversationsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ConversationTableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    private let viewModel = ConversationsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
