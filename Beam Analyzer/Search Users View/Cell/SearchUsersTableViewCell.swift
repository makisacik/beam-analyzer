//
//  SearchUsersTableViewCell.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 26.03.2023.
//

import UIKit
import SnapKit

final class SearchUsersTableViewCell: UITableViewCell {
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.getAppFont(withSize: 18)
        return label
    }()
    
    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.getAppFont(withSize: 18)
        label.textColor = .secondaryLabel
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
       
    private func setupView() {
        addSubview(userNameLabel)
        addSubview(fullNameLabel)

    }
    
    private func makeConstraints() {
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.snp.makeConstraints { make in
            make.height.equalTo(50).priority(.high)
            make.leading.equalToSuperview().inset(15)
            make.top.bottom.equalToSuperview()
        }
        
        fullNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(userNameLabel.snp.trailing).inset(10)
            make.trailing.equalToSuperview().inset(40)
            make.top.bottom.equalToSuperview()
        }
    }
    
    func configure(user: User) {
        userNameLabel.text = user.userName
        fullNameLabel.text = user.fullName
    }
}
