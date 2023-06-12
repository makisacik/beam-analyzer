//
//  SettingsViewController.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 27.03.2023.
//

import UIKit
import SnapKit

final class SettingsViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?

    private lazy var buttonSignOut: UIButton = {
        let button = UIButton()
        button.setTitle("Sign out", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemGroupedBackground
        button.addTarget(self, action: #selector(didTapSignOutButton), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var buttonChangePassword: UIButton = {
        let button = UIButton()
        button.setTitle("Change Password", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemGroupedBackground
        button.addTarget(self, action: #selector(didTapChangePassword), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        makeConstraints()
    }
    
    private func setupViews() {
        self.title = "Settings"
        view.backgroundColor = .systemBackground
        view.addSubview(buttonSignOut)
        view.addSubview(buttonChangePassword)
    }

    private func makeConstraints() {
        buttonChangePassword.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(60)
        }
        
        buttonSignOut.snp.makeConstraints { make in
            make.top.equalTo(buttonChangePassword.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(60)
        }
    }
    
    @objc private func didTapSignOutButton() {
        AuthService.shared.signOutUser { [weak self] isSuccessful in
            if isSuccessful {
                self?.coordinator?.navigateToLogin()
                UserManager.shared.currentUser = nil
                if let currentUser = AuthService.shared.auth.currentUser {
                    print("Current user sign out")
                }

            }
        }
    }
    
    @objc private func didTapChangePassword() {
        coordinator?.navigateToChangePassword()
    }

}
