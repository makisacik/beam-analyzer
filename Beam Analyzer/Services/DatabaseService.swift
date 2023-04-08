//
//  DatabaseService.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 13.03.2023.
//

import Foundation
import FirebaseDatabase

enum FetchUserError: Error {
    case noUser
    case databaseError
}

enum SearchUserError: Error {
    case unknownError
}

struct User {
    let userName: String
    let fullName: String
    let email: String
}

final class DatabaseService {
    static let shared = DatabaseService()
    private let database = Database.database().reference()
    
    private init() { }
    
    func insertUser(with user: User) {
        database.child("users").child(user.userName).setValue([
            "full_name": user.fullName,
            "email": user.email
        ])
    }
    
    func isUserExist(userName: String, completionHandler: @escaping (Bool) -> Void) {
        database.child("users").getData { _, snapshot in
            if let snapshot {
                completionHandler(snapshot.hasChild(userName))
            } else {
                completionHandler(false)
            }
        }
    }

    func fetchUser(with userName: String, completionHandler: @escaping (Result<User, FetchUserError>) -> Void ) {
        database.child("users").child(userName).observe(.value) { snapshot in
            guard let userDictionary = snapshot.value as? [String: String],
                  let fullName = userDictionary["full_name"],
                  let email = userDictionary["email"] else {
                completionHandler(.failure(FetchUserError.noUser))
                return
            }
            
            let user = User(userName: userName, fullName: fullName, email: email)
            completionHandler(.success(user))
            
        } withCancel: { _ in
            completionHandler(.failure(FetchUserError.databaseError))
        }
    }
    
    func fetchUser(email: String, completionHandler: @escaping (Result<User, FetchUserError>) -> Void ) {
        database.child("users").observe(.value) { snapshot in
            guard let userDictionary = snapshot.value as? [String: [String: String]] else {
                completionHandler(.failure(FetchUserError.databaseError))
                return
            }
            
            for user in userDictionary where email == user.value["email"] {
                guard let fullName = user.value["full_name"], let email = user.value["email"] else {
                    completionHandler(.failure(FetchUserError.databaseError))
                    return
                }
                let resultUser = User(userName: user.key, fullName: fullName, email: email)
                completionHandler(.success(resultUser))
            }
        } withCancel: { _ in
            completionHandler(.failure(FetchUserError.databaseError))
        }
    }
    
    func queryUsers(with searchText: String, completionHandler: @escaping (Result<[User], SearchUserError>) -> Void) {
        
        database.child("users").queryOrderedByKey().queryStarting(atValue: searchText).queryEnding(atValue: searchText + "\u{f8ff}").observe(.value) { snapshot in
            guard let userDictionary = snapshot.value as? [String: [String: String]] else {
                completionHandler(.success([]))
                return
            }
            let resultUsers = userDictionary.compactMap { (key, value) -> User? in
                guard let fullName = value["full_name"], let email = value["email"] else {
                    return nil
                }
                return User(userName: key, fullName: fullName, email: email)
            }
            completionHandler(.success(resultUsers))
            
        } withCancel: { _ in
            completionHandler(.failure(SearchUserError.unknownError))
        }
        
    }
    
}
