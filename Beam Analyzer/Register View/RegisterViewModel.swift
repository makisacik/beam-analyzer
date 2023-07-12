//
//  RegisterViewModel.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 15.02.2023.
//

import Foundation
import FirebaseAuth

final class RegisterViewModel {
    func register(withEmail: String, password: String, passwordAgain: String, fullName: String, userName: String, completionHandler: @escaping (String?) -> Void) {
        
        var errorString: String?
        
        if password.isEmpty || passwordAgain.isEmpty || withEmail.isEmpty || fullName.isEmpty || userName.isEmpty {
            errorString = "All fields must be filled."
        } else if password != passwordAgain {
            errorString = "Passwords do not match."
        } else if !isPasswordValid(password) {
            errorString = "Password should be at least 8 characters and should contain at least one letter and number."
        } else if fullName.count > 32 {
            errorString = "Full name can't be more than 32 characters."
        } else if !isValidUsername(userName) {
            errorString = "User name should be more than 4 less than 32 and should not contain any special characters."
        } else if !(userName == userName.lowercased()) {
            errorString = "User name should be lowercased."
        }
        
        if let errorString {
            completionHandler(errorString)
            return
        }
        
        DatabaseService.shared.isUserExist(userName: userName) { isExists in
            if !isExists {
                AuthService.shared.register(withEmail: withEmail, password: password) { authDataResult in
                    switch authDataResult {
                    case .success:
                        break
                    case .failure(let failure):
                        errorString = failure.localizedDescription
                    }
                    completionHandler(errorString)
                }
                DatabaseService.shared.insertUser(with: User( userName: userName, fullName: fullName, email: withEmail))
            } else {
                errorString = "Username is taken."
                completionHandler(errorString)
            }
        }
    }
    
    private func isPasswordValid(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"

        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
    private func isValidUsername(_ username: String) -> Bool {
        let alphanumericRegex = "^[a-zA-Z0-9]+$"
        let regex = try? NSRegularExpression(pattern: alphanumericRegex, options: [])
        let range = NSRange(location: 0, length: username.utf16.count)
        let matches = regex?.numberOfMatches(in: username, options: [], range: range)
        return matches == 1
    }
}
