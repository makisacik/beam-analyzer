//
//  ChangePasswordViewModel.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 30.05.2023.
//

import Foundation

final class ChangePasswordViewModel {
    
    func changePassword(firstPassword: String?, secondPassword: String?, completionHandler: @escaping (String?) -> Void) {
        if let firstPassword, let secondPassword {
            if firstPassword != secondPassword {
                print(firstPassword, secondPassword)
                completionHandler("Passwords does not match")
            } else if firstPassword.count < 6 {
                completionHandler("Password must be filled.")
            } else {
                AuthService.shared.updatePassword(password: firstPassword) { error in
                    if error != nil {
                        completionHandler(error?.localizedDescription ?? "Unknown Error")
                    } else {
                        completionHandler(nil)
                    }
                }
            }
        } else {
            completionHandler("Both fields should be filled.")
        }
        
    }

}
