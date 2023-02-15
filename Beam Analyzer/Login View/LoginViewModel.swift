//
//  LoginViewModel.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 10.02.2023.
//

import Foundation
import FirebaseAuth

final class LoginViewModel {

    func login(withEmail: String, password: String, completionHandler: @escaping (Bool) -> Void) {
        AuthService.shared.login(withEmail: withEmail, password: password) { authDataResult in
            switch authDataResult {
            case .success:
                completionHandler(true)
            case .failure:
                completionHandler(false)
            }
        }
    }

}
