//
//  AuthService.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 10.02.2023.
//

import Foundation
import FirebaseAuth

enum AuthError: Error {
    case unknownError
}

final class AuthService {

    static let shared = AuthService()
    let auth = Auth.auth()
    private var error: Error?

    private init() { }

    func login(withEmail: String, password: String, completionHandler: @escaping (Result<AuthDataResult, Error>) -> Void) {
        auth.signIn(withEmail: withEmail, password: password) { authResult, error in
            if let error {
                completionHandler(.failure(error))
                return
            }
            guard let authResult else {
                completionHandler(.failure(AuthError.unknownError))
                return
            }
            completionHandler(.success(authResult))
        }
    }

    func register(withEmail: String, password: String, completionHandler: @escaping (Result<AuthDataResult, Error>) -> Void) {
        auth.createUser(withEmail: withEmail, password: password) { authResult, error in
            if let error {
                completionHandler(.failure(error))
                return
            }
            guard let authResult else {
                completionHandler(.failure(AuthError.unknownError))
                return
            }
            completionHandler(.success(authResult))
        }
    }
    
    func isUserSignedIn() -> Bool {
        return auth.currentUser != nil
    }
    
    func signOutUser(completionHandler: @escaping (Bool) -> Void) {
        do {
            try auth.signOut()
            completionHandler(true)
        } catch _ {
            completionHandler(false)
        }
    }
}
