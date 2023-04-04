//
//  ChatViewModel.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 28.03.2023.
//

import Foundation
import RxSwift

final class ChatViewModel {
    private let receiverUser: User
    var currentUser: User!
    
    var messages = BehaviorSubject<[Message]>(value: [])

    init(receiverUser: User) {
        self.receiverUser = receiverUser
        currentUser = UserManager.shared.currentUser
        loadMessages()
    }
    
    func sendMessage(message: String) {
        MessageService.shared.sendMessage(message: message, currentUserName: currentUser.userName, receiverUserName: receiverUser.userName)
    }
    
    func loadMessages() {
        MessageService.shared.loadMessages(currentUserName: currentUser.userName, receiverUserName: receiverUser.userName) { [weak self] result in
            switch result {
            case .success(let messages):
                self?.messages.onNext(messages)
            case .failure(let failure):
                debugPrint(failure.localizedDescription)
            }
        }
    }
    
}
