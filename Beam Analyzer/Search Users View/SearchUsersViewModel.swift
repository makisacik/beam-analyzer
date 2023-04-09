//
//  SearchUsersViewModel.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 26.03.2023.
//

import Foundation

final class SearchUsersViewModel {
    func searchUser(with searchText: String, completionHandler: @escaping ([User]?) -> Void ) {
        DatabaseService.shared.queryUsers(with: searchText) { result in
            switch result {
            case .success(let users):
                completionHandler(users)
            case .failure:
                completionHandler(nil)
            }
        }
    }
}
