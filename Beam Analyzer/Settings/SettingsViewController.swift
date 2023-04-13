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

    private lazy var signOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign out", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .tertiaryLabel
        button.addTarget(self, action: #selector(didTapSignOutButton), for: .touchUpInside)
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
        view.addSubview(signOutButton)
    }

    private func makeConstraints() {
        signOutButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc private func didTapSignOutButton() {
        AuthService.shared.signOutUser { [weak self] isSuccessful in
            if isSuccessful {
                self?.coordinator?.navigateToLogin()
            }
        }
    }
}
