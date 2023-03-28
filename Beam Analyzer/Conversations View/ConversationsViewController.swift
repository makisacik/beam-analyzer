//
//  ConversationsViewController.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 20.03.2023.
//

import UIKit
import SnapKit

final class ConversationsViewController: UIViewController {
    
    private let conversationsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ConversationTableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    weak var coordinator: AppCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        makeConstraints()
    }
    
    private func setupViews() {
        view.addSubview(conversationsTableView)
        conversationsTableView.dataSource = self
        conversationsTableView.delegate = self
        view.backgroundColor = .systemBackground
    }
    
    private func makeConstraints() {
        conversationsTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension ConversationsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ConversationTableViewCell else { return UITableViewCell()}
        cell.textLabel?.text = "Row \(indexPath.row + 1)"
        cell.accessoryType = .disclosureIndicator
        cell.configure()
        return cell
    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        coordinator?.navigateToChat()
//    }
}
