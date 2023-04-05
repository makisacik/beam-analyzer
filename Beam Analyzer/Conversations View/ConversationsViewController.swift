//
//  ConversationsViewController.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 20.03.2023.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ConversationsViewController: UIViewController, UITableViewDelegate {
    
    private let conversationsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ConversationTableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    weak var coordinator: AppCoordinator?
    private let viewModel = ConversationsViewModel()
    private var disposeBag = DisposeBag()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchConversations()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        makeConstraints()
        showLoadingAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.removeListeners()
    }
    
    private func setupViews() {
        view.addSubview(conversationsTableView)
        view.backgroundColor = .systemBackground
        bindTableView()
    }
    
    private func makeConstraints() {
        conversationsTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func bindTableView() {
        conversationsTableView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel.userNames.bind(to: conversationsTableView.rx.items(cellIdentifier: "cell", cellType: ConversationTableViewCell.self)) { (_, userName, cell) in
            cell.textLabel?.text = userName
            cell.accessoryType = .disclosureIndicator
        }.disposed(by: disposeBag)
        
        conversationsTableView.rx.modelSelected(String.self).subscribe(onNext: { item in
            DispatchQueue.main.async {
                self.showLoadingAnimation()
            }
            DatabaseService.shared.fetchUser(with: item) { result in
                DispatchQueue.main.async {
                    self.hideLoadingAnimation()
                }
                switch result {
                case .success(let user):
                    self.coordinator?.navigateToChat(with: user)
                case .failure:
                    break
                }
            }
            print("SelectedItem: \(item)")
        }).disposed(by: disposeBag)
        
        viewModel.userNames.bind { _ in
            DispatchQueue.main.async {
                self.hideLoadingAnimation()
            }
        }.disposed(by: disposeBag)
    }

}
