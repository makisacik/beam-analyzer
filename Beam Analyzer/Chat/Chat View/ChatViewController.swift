//
//  ChatViewController.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 20.03.2023.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class ChatViewController: UIViewController, UITableViewDelegate {
    
    private let messageTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .default
        textField.placeholder = "Message"
        return textField
    }()
    
    private let messageTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    weak var coordinator: AppCoordinator?
    let viewModel: ChatViewModel
    private lazy var keyboardOutsideTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    private var disposeBag = DisposeBag()
    let receiverUser: User
    
    init(receiverUser: User) {
        self.viewModel = ChatViewModel(receiverUser: receiverUser)
        self.receiverUser = receiverUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        navigationController?.navigationBar.backgroundColor = .systemBackground
        setupViews()
        makeConstraints()
        self.isModalInPresentation = true
        if navigationController == nil {
            addNavBarWithDismiss()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.removeListeners()
        disposeBag = DisposeBag()
        viewModel.messages.dispose()
    }
    
    private func setupViews() {
        bindTableView()
        view.addSubview(messageTextField)
        view.addSubview(messageTableView)
        messageTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.title = "Chat with " + receiverUser.userName
    }
    
    private func makeConstraints() {
        messageTextField.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        if navigationController == nil {
            messageTableView.snp.makeConstraints { make in
                make.bottom.equalTo(messageTextField.snp.top)
                make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
                make.top.equalTo(view.safeAreaLayoutGuide).offset(44)
            }
        } else {
            messageTableView.snp.makeConstraints { make in
                make.bottom.equalTo(messageTextField.snp.top)
                make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            }
        }

    }
    
    private func bindTableView() {
        
        messageTableView.rx.setDelegate(self).disposed(by: disposeBag)
        viewModel.messages.bind(to: messageTableView.rx.items(cellIdentifier: "cell", cellType: ChatTableViewCell.self)) { (_, message, cell) in
            let isIconOnRight = message.sender == self.viewModel.currentUser.userName
            cell.configure(message: message, isIconOnRight: isIconOnRight)
            cell.selectionStyle = .none
        }.disposed(by: disposeBag)
        
        messageTableView.rx.modelSelected(Message.self).subscribe(onNext: { item in
            print(item.body)
            if let deflectionCalculation = JsonUtil.convertToObject(jsonString: item.body, objectType: DeflectionCalculation.self) {
                let resultVC = CalculationResultViewController(deflectionCalculation: deflectionCalculation)
                self.present(resultVC, animated: true)
            }
        }).disposed(by: disposeBag)
        
        viewModel.messages.bind { _ in
            self.scrollToBottom()
        }.disposed(by: disposeBag)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        view.addGestureRecognizer(keyboardOutsideTap)
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            messageTextField.snp.updateConstraints { make in
                make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-keyboardSize.height)
            }

        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        view.removeGestureRecognizer(keyboardOutsideTap)
        messageTextField.snp.updateConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc private func dismissKeyboard() {
        messageTextField.resignFirstResponder()
    }
    
    private func scrollToBottom() {
        if messageTableView.numberOfRows(inSection: 0) > 0 {
            let lastRowIndex = messageTableView.numberOfRows(inSection: 0) - 1
            let lastRowIndexPath = IndexPath(row: lastRowIndex, section: 0)
            messageTableView.scrollToRow(at: lastRowIndexPath, at: .bottom, animated: true)
        }
    }
    
    private func addNavBarWithDismiss() {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        let navItem = UINavigationItem(title: receiverUser.userName)
        let leftButton = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(dismissButtonTapped))
        navItem.leftBarButtonItem = leftButton
        navBar.items = [navItem]
        view.addSubview(navBar)
    }
    
    @objc func dismissButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func checkExistingConversation() {
        if messageTableView.numberOfRows(inSection: 0) == 0 {
            viewModel.createConversations()
        }
    }
}

extension ChatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        checkExistingConversation()
        viewModel.sendMessage(message: textField.text ?? "")
        textField.text = ""
        textField.resignFirstResponder()
        return true
    }
}
