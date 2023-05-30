//
//  CalculationsMenuViewController.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 29.05.2023.
//

import UIKit
import SnapKit

final class CalculationsMenuViewController: UIViewController {

    private let cardViewFreeEndCareer: CardView = {
        let cardView = CardView()
        cardView.cornerRadius = 10
        cardView.backgroundColor = .systemBackground
        cardView.shadowColor = .label
        return cardView
    }()
    
    private let imgViewFreeEndCareer: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "free_end")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let labelFreeEndCareer: UILabel = {
        let label = UILabel()
        label.font = UIFont.getBoldAppFont(withSize: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Free End Support (Cantilever)"
        return label
    }()
    // roller
    private let cardViewRoller: CardView = {
        let cardView = CardView()
        cardView.cornerRadius = 10
        cardView.backgroundColor = .systemBackground
        cardView.shadowColor = .label
        return cardView
    }()
    
    private let imgViewRoller: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "roller_simply_support")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let labelRoller: UILabel = {
        let label = UILabel()
        label.font = UIFont.getBoldAppFont(withSize: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Roller Support"
        return label
    }()
    // fixed
    private let cardViewFixed: CardView = {
        let cardView = CardView()
        cardView.cornerRadius = 10
        cardView.backgroundColor = .systemBackground
        cardView.shadowColor = .label
        return cardView
    }()
    
    private let imgViewFixed: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "fixed_end")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let labelFixed: UILabel = {
        let label = UILabel()
        label.font = UIFont.getBoldAppFont(withSize: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Fixed Support"
        return label
    }()
    // simply pinned
    private let cardViewSimplyPinned: CardView = {
        let cardView = CardView()
        cardView.cornerRadius = 10
        cardView.backgroundColor = .systemBackground
        cardView.shadowColor = .label
        return cardView
    }()
    
    private let imgViewSimplyPinned: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "roller_simply_support")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let labelSimplyPinned: UILabel = {
        let label = UILabel()
        label.font = UIFont.getBoldAppFont(withSize: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Simply (Pinned) Support"
        return label
    }()
    
    weak var coordinator: AppCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        makeConstraints()
        addCardViewTaps()
    }

    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(cardViewFreeEndCareer)
        view.addSubview(cardViewFixed)
        view.addSubview(cardViewRoller)
        view.addSubview(cardViewSimplyPinned)
        
        cardViewFreeEndCareer.addSubview(imgViewFreeEndCareer)
        cardViewFreeEndCareer.addSubview(labelFreeEndCareer)
        
        cardViewFixed.addSubview(imgViewFixed)
        cardViewFixed.addSubview(labelFixed)

        cardViewRoller.addSubview(imgViewRoller)
        cardViewRoller.addSubview(labelRoller)

        cardViewSimplyPinned.addSubview(imgViewSimplyPinned)
        cardViewSimplyPinned.addSubview(labelSimplyPinned)

        title = "Calculation Types"
    }
    
    private func makeConstraints() {
        cardViewFreeEndCareer.snp.makeConstraints { make in
            make.height.equalTo(140)
            make.leading.trailing.equalToSuperview().inset(60)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
        }

        cardViewFixed.snp.makeConstraints { make in
            make.height.equalTo(110)
            make.leading.trailing.equalToSuperview().inset(60)
            make.top.equalTo(cardViewFreeEndCareer.snp.bottom).offset(20)
        }

        cardViewRoller.snp.makeConstraints { make in
            make.height.equalTo(110)
            make.leading.trailing.equalToSuperview().inset(60)
            make.top.equalTo(cardViewFixed.snp.bottom).offset(20)
        }

        cardViewSimplyPinned.snp.makeConstraints { make in
            make.height.equalTo(110)
            make.leading.trailing.equalToSuperview().inset(60)
            make.top.equalTo(cardViewRoller.snp.bottom).offset(20)
        }
        
        imgViewFreeEndCareer.snp.makeConstraints { make in
            make.trailing.leading.top.equalToSuperview().inset(5)
            make.height.equalTo(70)
        }
        
        labelFreeEndCareer.snp.makeConstraints { make in
            make.top.equalTo(imgViewFreeEndCareer.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalToSuperview().inset(10)
        }
        
        imgViewFixed.snp.makeConstraints { make in
            make.trailing.leading.top.equalToSuperview().inset(5)
            make.height.equalTo(70)
        }
        
        labelFixed.snp.makeConstraints { make in
            make.top.equalTo(imgViewFixed.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalToSuperview().inset(10)
        }
        
        imgViewRoller.snp.makeConstraints { make in
            make.trailing.leading.top.equalToSuperview().inset(5)
            make.height.equalTo(70)
        }
        
        labelRoller.snp.makeConstraints { make in
            make.top.equalTo(imgViewRoller.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalToSuperview().inset(10)
        }
        
        imgViewSimplyPinned.snp.makeConstraints { make in
            make.trailing.leading.top.equalToSuperview().inset(5)
            make.height.equalTo(70)
        }
        
        labelSimplyPinned.snp.makeConstraints { make in
            make.top.equalTo(imgViewSimplyPinned.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalToSuperview().inset(10)
        }
        
    }
    
    private func addCardViewTaps() {
        let freeEndTap = UITapGestureRecognizer(target: self, action: #selector(freeEndCardViewTapped))
        
        let fixedTap = UITapGestureRecognizer(target: self, action: #selector(fixedCardViewTapped))
        let rollerTap = UITapGestureRecognizer(target: self, action: #selector(rollerCardViewTapped))
        let simplyPinnedTap = UITapGestureRecognizer(target: self, action: #selector(simplyCardViewTapped))

        cardViewFreeEndCareer.addGestureRecognizer(freeEndTap)
        cardViewFixed.addGestureRecognizer(fixedTap)
        cardViewRoller.addGestureRecognizer(rollerTap)
        cardViewSimplyPinned.addGestureRecognizer(simplyPinnedTap)
    }
    
    @objc func freeEndCardViewTapped() {
        coordinator?.navigateToInputs(calculationType: .freeEnd)
    }
    
    @objc func fixedCardViewTapped() {
        coordinator?.navigateToInputs(calculationType: .fixed)
    }
    
    @objc func rollerCardViewTapped() {
        coordinator?.navigateToInputs(calculationType: .roller)
    }
    
    @objc func simplyCardViewTapped() {
        coordinator?.navigateToInputs(calculationType: .simply)
    }
}
