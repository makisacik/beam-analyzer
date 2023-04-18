//
//  MenuViewModel.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 20.03.2023.
//

import Foundation

final class MenuViewModel {
    func fetchCurrentUser(completionHandler: @escaping (Error?) -> Void) {
        UserManager.shared.fetchCurrentUser { error in
            completionHandler(error)
        }
    }
}
