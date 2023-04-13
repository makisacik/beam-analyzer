//
//  CalculationViewController.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 12.04.2023.
//

import UIKit
import SnapKit

class MockCalculationViewController: UIViewController {
    
    private let stackViewCalculationInputs: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    private let stackViewLenghtOfBeam: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    private let labelLenghtOfBeam: UILabel = {
        let label = UILabel()
        label.text = "Lenght of beam:"
        label.font = UIFont.getAppFont(withSize: 17)
        return label
    }()
    
    private let textFieldLenghtOfBeam: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.returnKeyType = .default
        return textField
    }()
    
    private lazy var buttonCalculate: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.setTitle("Calculate", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .tertiaryLabel
        button.addTarget(self, action: #selector(didTapCalculateButton), for: .touchUpInside)
        return button
    }()
    
    weak var coordinator: AppCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        makeConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        stackViewLenghtOfBeam.addArrangedSubviews([labelLenghtOfBeam, textFieldLenghtOfBeam])
        stackViewCalculationInputs.addArrangedSubview(stackViewLenghtOfBeam)
        view.addSubview(stackViewCalculationInputs)
        view.addSubview(buttonCalculate)
    }
    
    private func makeConstraints() {
        stackViewCalculationInputs.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide).inset(60)
        }
        
        textFieldLenghtOfBeam.snp.makeConstraints { make in
            make.width.equalTo(60)
        }
        
        buttonCalculate.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(stackViewCalculationInputs.snp.bottom).offset(80)
        }
        
    }
    
    @objc private func didTapCalculateButton() {
        coordinator?.navigateToMockCalculationResults()
    }
    
}
