//
//  RegisterViewController.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 15.02.2023.
//

import UIKit
import SnapKit
import FirebaseDatabase

final class RegisterViewController: UIViewController {

    private let registerViewModel: RegisterViewModel = RegisterViewModel()
    private var activityIndicator: UIActivityIndicatorView?
    weak var coordinator: AppCoordinator?

    private let registerTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Register"
        label.font = UIFont.getAppFont(withSize: 26)
        return label
    }()

    private let registerCardView: CardView = {
        let cardView = CardView()
        cardView.cornerRadius = 10
        cardView.backgroundColor = .systemBackground
        cardView.shadowColor = .label
        return cardView
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Full Name: "
        label.font = UIFont.getAppFont(withSize: 17)
        return label
    }()
    
    private let fullNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .default
        textField.autocorrectionType = .no
        return textField
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "User Name: "
        label.font = UIFont.getAppFont(withSize: 17)
        return label
    }()
    
    private let userNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.returnKeyType = .default
        textField.autocorrectionType = .no

        return textField
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email: "
        label.font = UIFont.getAppFont(withSize: 17)
        return label
    }()

    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textContentType = .emailAddress
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.returnKeyType = .default
        textField.autocorrectionType = .no

        return textField
    }()

    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password: "
        label.font = UIFont.getAppFont(withSize: 17)
        return label
    }()

    private let passwordAgainLabel: UILabel = {
        let label = UILabel()
        label.text = "Password: (Again)"
        label.font = UIFont.getAppFont(withSize: 17)
        return label
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.returnKeyType = .default
        textField.passwordRules = .none
        return textField
    }()

    private let passwordAgainTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.returnKeyType = .default
        textField.passwordRules = .none

        return textField
    }()

    private let registerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()

    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .tertiaryLabel
        button.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        return button
    }()

    private let warningLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.getAppFont(withSize: 14)
        label.textColor = .systemRed
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordAgainTextField.delegate = self

        setupViews()
        addTapOutsideKeyboard()
    }

    private func addTapOutsideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    @objc private func didTapRegisterButton() {
        activityIndicator = showLoadingIndicator()
        registerViewModel.register(withEmail: emailTextField.text ?? "",
                                   password: passwordTextField.text ?? "",
                                   passwordAgain: passwordAgainTextField.text ?? "",
                                   fullName: fullNameTextField.text ?? "",
                                   userName: userNameTextField.text ?? "") { [weak self] errorString in
            self?.stopLoadingIndicator(activityIndicator: self?.activityIndicator)
            if let errorString {
                self?.warningLabel.text = errorString
            } else {
                self?.warningLabel.textColor = .systemBlue
                self?.warningLabel.text = "Registered Succesfully"
                self?.coordinator?.navigateToMenu()
            }

        }
    }

    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(registerTitleLabel)
        view.addSubview(registerCardView)
        registerCardView.addSubview(registerStackView)
        registerCardView.addSubview(registerButton)
        registerCardView.addSubview(warningLabel)
        registerStackView.addArrangedSubviews([fullNameLabel, fullNameTextField, userNameLabel, userNameTextField, emailLabel, emailTextField, passwordLabel, passwordTextField, passwordAgainLabel, passwordAgainTextField ])

        makeConstraints()
    }

    private func makeConstraints() {
        registerTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.centerX.equalToSuperview()
        }

        registerCardView.snp.makeConstraints { make in
            make.top.equalTo(registerTitleLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(15)
        }

        registerStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.right.equalToSuperview().inset(8)
        }

        warningLabel.snp.makeConstraints { make in
            make.top.equalTo(registerStackView.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(10)
        }

        registerButton.snp.makeConstraints { make in
            make.top.equalTo(warningLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(15)
            make.left.right.equalToSuperview().inset(5)
            make.height.equalTo(35)
        }

    }

}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            passwordAgainTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            didTapRegisterButton()
        }
        return true
    }
}
