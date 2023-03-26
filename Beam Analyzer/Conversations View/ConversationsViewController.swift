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
    
    private let usersSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Users Here"
        return searchBar
    }()
    
    weak var coordinator: AppCoordinator?
    private lazy var tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        makeConstraints()
    }
    
    private func setupViews() {
        self.title = "Conversations"
        view.addSubview(usersSearchBar)
        view.addSubview(conversationsTableView)
        conversationsTableView.dataSource = self
        conversationsTableView.delegate = self
        view.backgroundColor = .systemBackground
    }
    
    private func makeConstraints() {
        usersSearchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        
        conversationsTableView.snp.makeConstraints { make in
            make.top.equalTo(usersSearchBar.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()

        }
    }
    
    @objc private func dismissKeyboard() {
        
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.navigateToChat()
    }
}

extension ConversationsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
