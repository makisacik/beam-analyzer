//
//  RegisterViewModel.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 15.02.2023.
//

import Foundation
import FirebaseAuth

final class RegisterViewModel {
    func register(withEmail: String, password: String, passwordAgain: String, completionHandler: @escaping (String?) -> Void) {

        var errorString: String?

        if password.isEmpty || passwordAgain.isEmpty || withEmail.isEmpty {
            errorString = "All field must be filled."
        } else if password != passwordAgain {
            errorString = "Passwords do not match."
        } else if !isPasswordValid(password) {
            errorString = "Password should be at least 8 characters and should contain at least one character."
        }

        if let errorString {
            completionHandler(errorString)
            return
        }

        AuthService.shared.register(withEmail: withEmail, password: password) { authDataResult in
            switch authDataResult {
            case .success:
                break
            case .failure(let failure):
                errorString = failure.localizedDescription
            }
            completionHandler(errorString)
        }

    }

    private func isPasswordValid(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])[A-Za-z\\d@$!%*?&]{8,}$"

        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }

}
