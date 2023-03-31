//
//  ChatTableViewCell.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 30.03.2023.
//

import UIKit
import SnapKit

final class ChatTableViewCell: UITableViewCell {

    private let messageBodyLabel: UILabel = {
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
        addSubview(messageBodyLabel)
    }

    private func makeConstraints() {
        messageBodyLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15)
        }
    }
    
    func configure(messageBody: String) {
        messageBodyLabel.text = messageBody
    }
    
}
