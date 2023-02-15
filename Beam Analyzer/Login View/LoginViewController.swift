//
//  LoginViewController.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 10.02.2023.
//

import UIKit
import SnapKit

final class LoginViewController: UIViewController {

    private let loginViewModel: LoginViewModel = LoginViewModel()
    private var activityIndicator: UIActivityIndicatorView?

    private let loginTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Log In"
        label.font = UIFont.getAppFont(withSize: 26)
        return label
    }()

    private let loginCardView: CardView = {
        let cardView = CardView()
        cardView.cornerRadius = 10
        cardView.backgroundColor = .systemBackground
        cardView.shadowColor = .label
        return cardView
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

        return textField
    }()

    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password: "
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

        return textField
    }()

    private let loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .tertiaryLabel
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        return button
    }()

    private let warningLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = UIFont.getAppFont(withSize: 14)
        label.textColor = .systemRed
        return label
    }()

    private let registerLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account ?\nRegister now!"
        label.font = UIFont.getAppFont(withSize: 14)
        label.textColor = .tintColor
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let withoutSignInLabel: UILabel = {
        let label = UILabel()
        label.text = "Continue without signing in"
        label.font = UIFont.getAppFont(withSize: 14)
        label.textColor = .tintColor
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate = self
        emailTextField.delegate = self

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

    @objc private func didTapLoginButton() {
        activityIndicator = showLoadingIndicator()
        loginViewModel.login(withEmail: emailTextField.text ?? "", password: passwordTextField.text ?? "") { [weak self] isSuccessfull in
            if isSuccessfull {
                self?.warningLabel.textColor = .systemBlue
                self?.warningLabel.text = "Successful login"
            } else {
                self?.warningLabel.text = "Your credentials are incorrect."
                self?.warningLabel.shake()
            }
             self?.stopLoadingIndicator(activityIndicator: self?.activityIndicator)
        }
    }

    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(loginTitleLabel)
        view.addSubview(loginCardView)
        view.addSubview(registerLabel)
        view.addSubview(withoutSignInLabel)
        loginCardView.addSubview(loginStackView)
        loginCardView.addSubview(loginButton)
        loginCardView.addSubview(warningLabel)
        loginStackView.addArrangedSubview(emailLabel)
        loginStackView.addArrangedSubview(emailTextField)
        loginStackView.addArrangedSubview(passwordLabel)
        loginStackView.addArrangedSubview(passwordTextField)

        makeConstraints()
    }

    private func makeConstraints() {
        loginTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.centerX.equalToSuperview()
        }

        loginCardView.snp.makeConstraints { make in
            make.top.equalTo(loginTitleLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(15)
        }

        loginStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.right.equalToSuperview().inset(8)
        }

        warningLabel.snp.makeConstraints { make in
            make.top.equalTo(loginStackView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }

        loginButton.snp.makeConstraints { make in
            make.top.equalTo(warningLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().inset(15)
            make.left.right.equalToSuperview().inset(5)
            make.height.equalTo(35)
        }

        registerLabel.snp.makeConstraints { make in
            make.top.equalTo(loginCardView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }

        withoutSignInLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == passwordTextField {
            textField.resignFirstResponder()
            didTapLoginButton()
        } else {
            passwordTextField.becomeFirstResponder()
        }
        return true
    }
}
