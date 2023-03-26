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
    }
    
    private func makeConstraints() {
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.snp.makeConstraints { make in
            make.height.equalTo(50).priority(.high)
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.bottom.equalToSuperview()
        }
    }
    
    func configure(user: User) {
        userNameLabel.text = user.userName
    }
}
