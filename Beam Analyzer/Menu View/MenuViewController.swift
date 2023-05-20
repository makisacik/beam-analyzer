//
//  MenuViewController.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 20.03.2023.
//

import UIKit
import SnapKit

final class MenuViewController: UIViewController {
    
    private let cardViewMaximumDeflection: CardView = {
        let cardView = CardView()
        cardView.cornerRadius = 10
        cardView.backgroundColor = .systemGroupedBackground
        cardView.shadowColor = .label
        return cardView
    }()
    
    private let labelMaximumDeflection: UILabel = {
        let label = UILabel()
        label.text = "Calculate Maximum Deflection"
        label.numberOfLines = 0
        label.font = UIFont.getBoldAppFont(withSize: 20)
        
        return label
    }()
    
    private let cardViewSavedCalculations: CardView = {
        let cardView = CardView()
        cardView.cornerRadius = 10
        cardView.backgroundColor = .systemGroupedBackground
        cardView.shadowColor = .label
        return cardView
    }()
    
    private let labelSavedCalculations: UILabel = {
        let label = UILabel()
        label.text = "Saved Calculations"
        label.numberOfLines = 0
        label.font = UIFont.getBoldAppFont(withSize: 20)
        
        return label
    }()
    
    weak var coordinator: AppCoordinator?
    private let viewModel = MenuViewModel()
    
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
        
        view.addSubview(cardViewMaximumDeflection)
        view.addSubview(cardViewSavedCalculations)
        cardViewMaximumDeflection.addSubview(labelMaximumDeflection)
        cardViewSavedCalculations.addSubview(labelSavedCalculations)
        addMaximumDeflectionTap()
        addSavedCalculationsTap()
    }
    
    private func makeConstraints() {
        cardViewMaximumDeflection.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-130)
            make.width.equalTo(240)
            make.height.equalTo(100)
        }
        
        labelMaximumDeflection.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        cardViewSavedCalculations.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(cardViewMaximumDeflection.snp.bottom).offset(30)
            make.width.equalTo(240)
            make.height.equalTo(80)
        }
        
        labelSavedCalculations.snp.makeConstraints { make in
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
    
    private func addMaximumDeflectionTap() {
        let maximumDeflectionTap = UITapGestureRecognizer(target: self, action: #selector(maximumDeflectionTapped))
        cardViewMaximumDeflection.addGestureRecognizer(maximumDeflectionTap)
    }
    
    private func addSavedCalculationsTap() {
        let savedCalculationsTap = UITapGestureRecognizer(target: self, action: #selector(savedCalculationsTapped))
        cardViewSavedCalculations.addGestureRecognizer(savedCalculationsTap)
    }
    
    private func addNavBarButtons() {
        let messageButton = UIBarButtonItem(image: UIImage(systemName: "message"), style: .plain, target: self, action: #selector(messageButtonTapped))
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(settingsButtonTapped))
        messageButton.tintColor = .label
        settingsButton.tintColor = .label
        navigationItem.rightBarButtonItem = messageButton
        navigationItem.leftBarButtonItem = settingsButton
    }
    
    @objc func maximumDeflectionTapped() {
        coordinator?.navigateToMockCalculation()
    }

    @objc func savedCalculationsTapped() {
        coordinator?.navigateToSavedCalculations()
    }
    
    @objc func messageButtonTapped() {
        coordinator?.navigateToMessagingTabBar()
    }
    
    @objc func settingsButtonTapped() {
        coordinator?.navigateToSettings()
    }
    
}
