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
        button.backgroundColor = .tertiaryLabel
        button.addTarget(self, action: #selector(didTapSignOutButton), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var buttonChangePassword: UIButton = {
        let button = UIButton()
        button.setTitle("Change Password", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .tertiaryLabel
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
        buttonSignOut.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        buttonChangePassword.snp.makeConstraints { make in
            make.top.equalTo(buttonSignOut.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
    }
    
    @objc private func didTapSignOutButton() {
        AuthService.shared.signOutUser { [weak self] isSuccessful in
            if isSuccessful {
                self?.coordinator?.navigateToLogin()
            }
        }
    }
    
    @objc private func didTapChangePassword() {
        coordinator?.navigateToChangePassword()
    }

}
