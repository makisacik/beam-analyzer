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
        stackView.alignment = .top
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
    
    private let bubleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .secondarySystemBackground
        return(view)
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.getAppFont(withSize: 14)
        label.textAlignment = .center
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
        addSubview(mainStackView)
        bubleView.addSubview(messageBodyLabel)
        bubleView.addSubview(dateLabel)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.addArrangedSubviews([leftUserIcon, bubleView, rightUserIcon])
        dateLabel.textColor = .secondaryLabel
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
        
        messageBodyLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(35)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(10)
        }
    }
    
    func configure(message: Message, isIconOnRight: Bool) {
        if isIconOnRight {
            leftUserIcon.isHidden = true
            rightUserIcon.isHidden = false
        } else {
            leftUserIcon.isHidden = false
            rightUserIcon.isHidden = true
        }
        messageBodyLabel.text = message.body
        dateLabel.text = message.date
    }
    
}
