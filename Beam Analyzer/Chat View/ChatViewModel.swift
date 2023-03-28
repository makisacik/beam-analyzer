//
//  ChatViewModel.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 28.03.2023.
//

import Foundation

final class ChatViewModel {
    let receiverUser: User
    var currentUser: User?
    
    init(receiverUser: User) {
        self.receiverUser = receiverUser
        getCurrentUser()
    }
    
    func sendMessage(message: String) {
        
    }
    
    private func getCurrentUser() {
        if let email = AuthService.shared.auth.currentUser?.email {
            DatabaseService.shared.fetchUser(with: email) { result in
                switch result {
                case .success(let currentUser):
                    self.currentUser = currentUser
                case .failure:
                    break
                }
            }
        }
    }
    
}
