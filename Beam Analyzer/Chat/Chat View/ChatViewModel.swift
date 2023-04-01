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
        getCurrentUser()
    }
    
    func sendMessage(message: String) {
        MessageService.shared.sendMessage(message: message, currentUserName: currentUser.userName, receiverUserName: receiverUser.userName)
    }
    
    func loadMessages() {
        MessageService.shared.loadMessages(currentUserName: currentUser.userName, receiverUserName: receiverUser.userName) { result in
            switch result {
            case .success(let messages):
                self.messages.onNext(messages)
            case .failure(let failure):
                debugPrint(failure.localizedDescription)
            }
        }
    }
    
    private func getCurrentUser() {
        if let email = AuthService.shared.auth.currentUser?.email {
            DatabaseService.shared.fetchUser(email: email) { result in
                switch result {
                case .success(let currentUser):
                    self.currentUser = currentUser
                case .failure:
                    break
                }
                self.loadMessages()
            }
        }
    }
    
}
