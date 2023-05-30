//
//  ChangePasswordViewModel.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 30.05.2023.
//

import Foundation

final class ChangePasswordViewModel {
    
    func changePassword(currentPassword: String?, firstPassword: String?, secondPassword: String?, completionHandler: @escaping (String?) -> Void) {
        if let currentPassword, let firstPassword, let secondPassword {
            if firstPassword != secondPassword {
                print(firstPassword, secondPassword)
                completionHandler("Passwords does not match")
            } else if firstPassword.count < 6 {
                completionHandler("Password lenght should be at least 6 characters.")
            } else {
                AuthService.shared.updatePassword(currentPassword: currentPassword, password: firstPassword) { error in
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
