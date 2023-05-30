//
//  ChangePasswordViewController.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 30.05.2023.
//

import UIKit
import SnapKit

final class ChangePasswordViewController: UIViewController {

    lazy var cardViewPassword: CardView = {
        let cardView = CardView()
        cardView.cornerRadius = 10
        cardView.backgroundColor = .systemBackground
        cardView.shadowColor = .label
        view.addSubview(cardView)
        return cardView
    }()

    lazy var labelFirstPassword: UILabel = {
        let label = UILabel()
        label.text = "New Password"
        label.font = UIFont.getAppFont(withSize: 14)
        label.contentMode = .left
        return label
    }()

    lazy var labelSecondPassword: UILabel = {
        let label = UILabel()
        label.text = "New Password Again"
        label.font = UIFont.getAppFont(withSize: 14)
        label.contentMode = .left
        return label
    }()

    lazy var stackViewPassword: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelFirstPassword, textFieldFirstPassword, labelSecondPassword, textFieldSecondPassword, buttonChangePassword])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.setCustomSpacing(10, after: textFieldSecondPassword)
        return stackView
    }()

    lazy var textFieldFirstPassword: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.returnKeyType = .default
        return textField
    }()

    lazy var textFieldSecondPassword: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.returnKeyType = .default
        
        return textField
    }()

    lazy var buttonChangePassword: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.titleLabel?.contentMode = .center
        button.addTarget(self, action: #selector(actionChangePassword), for: .touchUpInside)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .secondarySystemBackground

        return button
    }()

    private let viewModel = ChangePasswordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        view.backgroundColor = .systemBackground
        title = "Change Password"
        cardViewPassword.addSubview(stackViewPassword)

        cardViewPassword.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.leading.trailing.equalToSuperview().inset(10)
        }

        stackViewPassword.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview().inset(10)
        }

        textFieldFirstPassword.snp.makeConstraints { make in
            make.height.equalTo(40)
        }

        textFieldSecondPassword.snp.makeConstraints { make in
            make.height.equalTo(40)
        }

        buttonChangePassword.snp.makeConstraints { make in
            make.height.equalTo(40)
        }

        labelFirstPassword.snp.makeConstraints { make in
            make.height.equalTo(20)
        }

        labelSecondPassword.snp.makeConstraints { make in
            make.height.equalTo(20)
        }

    }

    @objc func actionChangePassword() {
        viewModel.changePassword(firstPassword: textFieldFirstPassword.text, secondPassword: textFieldSecondPassword.text) { passwordError in
            if let passwordError {
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: passwordError)
                }
            } else {
                DispatchQueue.main.async {
                    self.showAlert(title: "Successful", message: "Pasword Changed Successfully")
                    self.textFieldFirstPassword.text = ""
                    self.textFieldSecondPassword.text = ""
                }
            }
        }
    }
    
}
