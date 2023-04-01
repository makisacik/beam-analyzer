//
//  ChatTableViewCell.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 30.03.2023.
//

import UIKit
import SnapKit

final class ChatTableViewCell: UITableViewCell {
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 5
        return stackView
    }()

    private let messageBodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.getAppFont(withSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let leftUserIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.circle"))
        imageView.tintColor = .secondaryLabel
        return imageView
    }()
    
    private let rightUserIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.circle"))
        imageView.tintColor = .secondaryLabel
        return imageView
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
        addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.addArrangedSubviews([leftUserIcon, messageBodyLabel, rightUserIcon])
    }
    
    private func makeConstraints() {
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15)
        }
        
        leftUserIcon.snp.makeConstraints { make in
            make.width.height.equalTo(35)
        }
        
        rightUserIcon.snp.makeConstraints { make in
            make.width.height.equalTo(35)
        }
        
    }
    
    func configure(messageBody: String, isIconOnRight: Bool) {
        if isIconOnRight {
            leftUserIcon.removeFromSuperview()
        } else {
            rightUserIcon.removeFromSuperview()
        }
        messageBodyLabel.text = messageBody
    }
    
}
