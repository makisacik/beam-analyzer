//
//  SearchUsersViewController.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 26.03.2023.
//

import UIKit
import SnapKit

final class SearchUsersViewController: UIViewController {
    
    private let conversationsTableView: UITableView = {
        let tableView = UITableView()
        // tableView.register(ConversationTableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    private let usersSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Users Here"
        searchBar.autocapitalizationType = .none
        return searchBar
    }()
    
    private lazy var tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    weak var coordinator: AppCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        makeConstraints()
    }
    
    private func setupViews() {
        view.addSubview(usersSearchBar)
        view.backgroundColor = .systemBackground
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    private func makeConstraints() {
        usersSearchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(40)
        }

    }
    
    @objc private func keyboardWillShow() {
        view.addGestureRecognizer(tap)
    }
    
    @objc private func keyboardDidHide() {
        view.removeGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        usersSearchBar.resignFirstResponder()
    }

}
