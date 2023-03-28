//
//  ChatViewController.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 20.03.2023.
//

import UIKit
import SnapKit

final class ChatViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    private var receiverUser: User
    private lazy var keyboardOutsideTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))

    private let messageTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .default
        textField.placeholder = "Message"
        return textField
    }()
    
    init(receiverUser: User) {
        self.receiverUser = receiverUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        
        setupViews()
        makeConstraints()
    }
    
    private func setupViews() {
        view.addSubview(messageTextField)
        messageTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func makeConstraints() {
        messageTextField.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        view.addGestureRecognizer(keyboardOutsideTap)
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc private func keyboardWillHide() {
        view.removeGestureRecognizer(keyboardOutsideTap)
        
        DispatchQueue.main.async {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
        }

    }
    
    @objc private func dismissKeyboard() {
        messageTextField.resignFirstResponder()
    }
}

extension ChatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.text = ""
        textField.resignFirstResponder()
        return true
    }
}
