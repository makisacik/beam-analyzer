//
//  CalculationResultViewController.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 5.05.2023.
//

import UIKit
import SnapKit

final class CalculationResultViewController: UIViewController {
    
    private let resultView: CardView = {
        let cardView = CardView()
        cardView.cornerRadius = 10
        cardView.backgroundColor = .systemBackground
        cardView.shadowColor = .label
        return cardView
    }()
    
    private let labelCalcTitle: UILabel = {
        let label = UILabel()
        label.text = "Maximum Deflection"
        label.font = UIFont.getBoldAppFont(withSize: 19)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let stackViewCalcInputs: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private let labelLenghtOfBeam: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.getAppFont(withSize: 17)
        return label
    }()

    private let labelWidthOfBeam: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.getAppFont(withSize: 17)
        return label
    }()
    
    private let labelHeightOfBeam: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.getAppFont(withSize: 17)
        return label
    }()
    
    private let labelPointLoad: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.getAppFont(withSize: 17)
        return label
    }()
    
    private let labelYoungModulus: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.getAppFont(withSize: 17)
        return label
    }()
    
    private let labelCalcResult: UILabel = {
        let label = UILabel()
        label.font = UIFont.getBoldAppFont(withSize: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var shareButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(systemName: "square.and.arrow.up")?.withTintColor(.secondaryLabel, renderingMode: .alwaysOriginal)
        button.setBackgroundImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)

        return button
    }()
    
    weak var coordinator: AppCoordinator?
    private let deflectionCalculation: DeflectionCalculation
    
    init(deflectionCalculation: DeflectionCalculation) {
        self.deflectionCalculation = deflectionCalculation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
        makeConstraints()
    }
    
    private func setupViews() {
        self.title = "Calculation Result"
        view.addSubview(resultView)
        resultView.addSubview(labelCalcTitle)
        resultView.addSubview(stackViewCalcInputs)
        resultView.addSubview(labelCalcResult)
        view.addSubview(shareButton)
        stackViewCalcInputs.addArrangedSubviews([labelLenghtOfBeam, labelWidthOfBeam, labelHeightOfBeam, labelPointLoad, labelYoungModulus])
        setResultViewTexts()
    }
    
    private func makeConstraints() {
        
        labelCalcTitle.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview().inset(20)
        }
        
        stackViewCalcInputs.snp.makeConstraints { make in
            make.top.equalTo(labelCalcTitle.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview()
        }
        
        labelCalcResult.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(stackViewCalcInputs.snp.bottom).offset(20)
        }
        
        resultView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(300)
        }
        
        shareButton.snp.makeConstraints { make in
            make.top.equalTo(resultView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(35)
        }
        
    }
    
    private func setResultViewTexts() {
        labelLenghtOfBeam.text = "Lenght of beam (m): \(deflectionCalculation.inputs.lenght)"
        labelWidthOfBeam.text = "Cross-section width (m): \(deflectionCalculation.inputs.width)"
        labelHeightOfBeam.text = "Cross-section height (m):  \(deflectionCalculation.inputs.height)"
        labelPointLoad.text = "Point load (N): \(deflectionCalculation.inputs.pointLoad)"
        labelYoungModulus.text = "Young's modulus (GPa): \(deflectionCalculation.inputs.youngModulus)"
        
        labelCalcResult.text = "Value: \(deflectionCalculation.result)"
    }
    
    @objc private func didTapShareButton() {
        let messagingTabBar = MessagingTabBarController(calculation: deflectionCalculation)
        self.present(messagingTabBar, animated: true)
    }
    
}
