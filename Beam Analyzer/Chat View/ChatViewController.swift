//
//  ChatViewController.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 20.03.2023.
//

import UIKit
import SnapKit

final class ChatViewController: UIViewController {
    
    private let chatTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    weak var coordinator: AppCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        makeConstraints()
    }
    
    private func setupViews() {
        self.title = "Chats"
        view.addSubview(chatTableView)
        chatTableView.dataSource = self
        chatTableView.delegate = self
    }
    
    private func makeConstraints() {
        chatTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MessageTableViewCell else { return UITableViewCell()}
        cell.textLabel?.text = "Row \(indexPath.row + 1)"
        cell.configure()
        return cell
    }

}
