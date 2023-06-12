//
//  SearchUsersViewController.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 26.03.2023.
//

import UIKit
import SnapKit
import NVActivityIndicatorView

final class SearchUsersViewController: UIViewController {
        
    private let searchUsersTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchUsersTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private let searchUsersSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Users Here"
        searchBar.autocapitalizationType = .none
        return searchBar
    }()
    
    private var resultUsers: [User]?
    
    private lazy var keyboardOutsideTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    private let viewModel = SearchUsersViewModel()
    private var deflectionCalculation: DeflectionCalculation?

    weak var coordinator: AppCoordinator?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    init(calculation: DeflectionCalculation) {
        deflectionCalculation = calculation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        makeConstraints()

    }
    
    private func setupViews() {
        view.addSubview(searchUsersSearchBar)
        view.addSubview(searchUsersTableView)
        searchUsersTableView.dataSource = self
        searchUsersTableView.delegate = self
        searchUsersSearchBar.delegate = self
        view.backgroundColor = .systemBackground
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    private func makeConstraints() {
        searchUsersSearchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        
        searchUsersTableView.snp.makeConstraints { make in
            make.top.equalTo(searchUsersSearchBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
                
    }
    
    @objc private func keyboardWillShow() {
        view.addGestureRecognizer(keyboardOutsideTap)
    }
    
    @objc private func keyboardDidHide() {
        view.removeGestureRecognizer(keyboardOutsideTap)
    }
    
    @objc private func dismissKeyboard() {
        searchUsersSearchBar.resignFirstResponder()
    }

}

extension SearchUsersViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        showLoadingAnimation()
        if let searchText = searchBar.text {
            viewModel.searchUser(with: searchText) { [weak self] users in
                DispatchQueue.main.async {
                    self?.hideLoadingAnimation()
                }
                guard let users else {
                    self?.showAlert()
                    return
                }
                
                self?.resultUsers = users.sorted(by: { $0.userName < $1.userName })
                DispatchQueue.main.async {
                    self?.searchUsersTableView.reloadData()
                }
            }
        }
        
    }
}

extension SearchUsersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultUsers?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SearchUsersTableViewCell else { return UITableViewCell()}
        cell.accessoryType = .disclosureIndicator
        if let user = resultUsers?[indexPath.row] {
            cell.configure(user: user)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let receiverUser = resultUsers?[indexPath.row] {
            if let calculation = deflectionCalculation {
                let chatVC = ChatViewController(receiverUser: receiverUser)
                chatVC.coordinator = self.coordinator
                
                if let json = JsonUtil.convertToJsonString(object: deflectionCalculation) {
                    chatVC.checkExistingConversation()
                    chatVC.viewModel.sendMessage(message: json)
                }
                self.present(chatVC, animated: true)
            } else {
                let chatVC = ChatViewController(receiverUser: receiverUser)
                present(chatVC, animated: true)
            }
        }
    }
}
