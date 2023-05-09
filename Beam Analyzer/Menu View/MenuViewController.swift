//
//  MenuViewController.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 20.03.2023.
//

import UIKit
import SnapKit

final class MenuViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    private let viewModel = MenuViewModel()
    
    private let cardViewMockCalculation: CardView = {
        let cardView = CardView()
        cardView.cornerRadius = 10
        cardView.backgroundColor = .systemGroupedBackground
        cardView.shadowColor = .label
        return cardView
    }()
    
    private let labelMockCalculation: UILabel = {
        let label = UILabel()
        label.text = "Calculate Maximum Deflection"
        label.numberOfLines = 0
        label.font = UIFont.getBoldAppFont(withSize: 20)
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        makeConstraints()
        showLoadingAnimation()
        viewModel.fetchCurrentUser { error in
            DispatchQueue.main.async {
                self.hideLoadingAnimation()
            }
            if error != nil {
                self.showError(title: "Error", message: "User cannot be fetched")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        self.title = "Menu"
        
        view.addSubview(cardViewMockCalculation)
        cardViewMockCalculation.addSubview(labelMockCalculation)
        
        let mockCardViewTap = UITapGestureRecognizer(target: self, action: #selector(mockCardViewTapped))
        cardViewMockCalculation.addGestureRecognizer(mockCardViewTap)
    }
    
    private func makeConstraints() {
        cardViewMockCalculation.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-130)
            make.width.equalTo(240)
            make.height.equalTo(120)
        }
        
        labelMockCalculation.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    private func setupNavBar() {
        navigationItem.hidesBackButton = true
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.prefersLargeTitles = true
        addNavBarButtons()
    }
    
    private func addNavBarButtons() {
        let messageButton = UIBarButtonItem(image: UIImage(systemName: "message"), style: .plain, target: self, action: #selector(messageButtonTapped))
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(settingsButtonTapped))
        messageButton.tintColor = .label
        settingsButton.tintColor = .label
        navigationItem.rightBarButtonItem = messageButton
        navigationItem.leftBarButtonItem = settingsButton
    }
    
    @objc func mockCardViewTapped() {
        coordinator?.navigateToMockCalculation()
    }

    @objc func messageButtonTapped() {
        coordinator?.navigateToMessagingTabBar()
    }
    
    @objc func settingsButtonTapped() {
        coordinator?.navigateToSettings()
    }
    
}
