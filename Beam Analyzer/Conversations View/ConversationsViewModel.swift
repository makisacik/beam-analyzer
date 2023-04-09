//
//  ConversationsViewModel.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 20.03.2023.
//

import Foundation
import RxSwift

final class ConversationsViewModel {
    let currentUser: User!
    
    var userNames = PublishSubject<[String]>()

    init() {
        currentUser = UserManager.shared.currentUser
    }
    
    func fetchConversations() {
        MessageService.shared.fetchConversations(userName: currentUser.userName) { result in
            switch result {
            case .success(let usernames):
                self.userNames.onNext(usernames)
            case .failure:
                break
            }
        }
    }
    
    func fetchUser(userName: String, completionHandler: @escaping (User?) -> Void) {
        DatabaseService.shared.fetchUser(userName: userName) { result in
            switch result {
            case .success(let user):
                completionHandler(user)
            case .failure:
                completionHandler(nil)
            }
        }
    }
    
    func removeListeners() {
        MessageService.shared.removeConversationsListener()
    }
}
