//
//  UserManager.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 3.04.2023.
//

import Foundation

final class UserManager {
    
    static let shared = UserManager()
    var currentUser: User?
    
    func fetchCurrentUser(completionHandler: @escaping (FetchUserError?) -> Void) {
        if let email = AuthService.shared.auth.currentUser?.email {
            DatabaseService.shared.fetchUser(email: email) { result in
                switch result {
                case .success(let currentUser):
                    self.currentUser = currentUser
                    completionHandler(nil)
                case .failure:
                    completionHandler(FetchUserError.databaseError)
                }
            }
        }
    }
    
}
