//
//  DatabaseService.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 13.03.2023.
//

import Foundation
import FirebaseDatabase

final class DatabaseService {
    static let shared = DatabaseService()
    private let database = Database.database().reference()
    
    func insertUser(with user: DatabaseUser) {
        database.child(user.userName).setValue([
            "full_name": user.fullName,
            "email": user.emailAddress
        ])
        
    }
    
    func isUserExists(userName: String, completionHandler: @escaping (Bool) -> Void) {
        database.observeSingleEvent(of: .value) { snapshot in
            completionHandler(snapshot.hasChild(userName))
        }
    }
}

struct DatabaseUser {
    let fullName: String
    let userName: String
    let emailAddress: String
}
