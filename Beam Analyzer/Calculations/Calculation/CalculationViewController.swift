//
//  CalculationViewController.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 12.04.2023.
//

import UIKit
import SnapKit

final class CalculationViewController: UIViewController {
    
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
        label.text = "Lenght of beam (m):"
        label.font = UIFont.getAppFont(withSize: 17)
        return label
    }()
    
    private let textFieldLenghtOfBeam: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.returnKeyType = .default
        return textField
    }()
    
    private let stackViewWidthOfBeam: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    private let labelWidthOfBeam: UILabel = {
        let label = UILabel()
        label.text = "Cross-section width (m):"
        label.font = UIFont.getAppFont(withSize: 17)
        return label
    }()
    
    private let textFieldWidthOfBeam: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.returnKeyType = .default
        return textField
    }()
    
    private let stackViewHeightOfBeam: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    private let labelHeightOfBeam: UILabel = {
        let label = UILabel()
        label.text = "Cross-section height (m):"
        label.font = UIFont.getAppFont(withSize: 17)
        return label
    }()
    
    private let textFieldHeightOfBeam: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.returnKeyType = .default
        return textField
    }()
    
    private let stackViewPointLoad: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    private let labelPointLoad: UILabel = {
        let label = UILabel()
        label.text = "Point load (N): "
        label.font = UIFont.getAppFont(withSize: 17)
        return label
    }()
    
    private let textFieldPointLoad: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.returnKeyType = .default
        return textField
    }()
    
    private let stackViewYoungModulus: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    private let labelYoungModulus: UILabel = {
        let label = UILabel()
        label.text = "Young's modulus (GPa): "
        label.font = UIFont.getAppFont(withSize: 17)
        return label
    }()
    
    private let textFieldYoungModulus: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
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
    private let deflectionCalculationUseCase = DeflectionCalculationUseCase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        makeConstraints()
    }
    
    private func setupViews() {
        self.title = "Enter Inputs"
        view.backgroundColor = .systemBackground
        stackViewLenghtOfBeam.addArrangedSubviews([labelLenghtOfBeam, textFieldLenghtOfBeam])
        stackViewWidthOfBeam.addArrangedSubviews([labelWidthOfBeam, textFieldWidthOfBeam])
        stackViewHeightOfBeam.addArrangedSubviews([labelHeightOfBeam, textFieldHeightOfBeam])
        stackViewPointLoad.addArrangedSubviews([labelPointLoad, textFieldPointLoad])
        stackViewYoungModulus.addArrangedSubviews([labelYoungModulus, textFieldYoungModulus])
        
        stackViewCalculationInputs.addArrangedSubview(stackViewLenghtOfBeam)
        stackViewCalculationInputs.addArrangedSubview(stackViewWidthOfBeam)
        stackViewCalculationInputs.addArrangedSubview(stackViewHeightOfBeam)
        stackViewCalculationInputs.addArrangedSubview(stackViewPointLoad)
        stackViewCalculationInputs.addArrangedSubview(stackViewYoungModulus)
        
        view.addSubview(stackViewCalculationInputs)
        view.addSubview(buttonCalculate)
    }
    
    private func makeConstraints() {
        stackViewCalculationInputs.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        textFieldLenghtOfBeam.snp.makeConstraints { make in
            make.width.equalTo(60)
        }
        
        textFieldWidthOfBeam.snp.makeConstraints { make in
            make.width.equalTo(60)
        }
        
        textFieldHeightOfBeam.snp.makeConstraints { make in
            make.width.equalTo(60)
        }
        
        textFieldPointLoad.snp.makeConstraints { make in
            make.width.equalTo(60)
        }
        
        textFieldYoungModulus.snp.makeConstraints { make in
            make.width.equalTo(60)
        }
        
        buttonCalculate.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalTo(stackViewCalculationInputs.snp.bottom).offset(40)
        }
    }
    
    @objc private func didTapCalculateButton() {
        if let lenght = Double(textFieldLenghtOfBeam.text?.replacingOccurrences(of: ",", with: ".") ?? ""),
           let width = Double(textFieldWidthOfBeam.text?.replacingOccurrences(of: ",", with: ".") ?? ""),
           let height = Double(textFieldHeightOfBeam.text?.replacingOccurrences(of: ",", with: ".") ?? ""),
           let pointLoad = Double(textFieldPointLoad.text?.replacingOccurrences(of: ",", with: ".") ?? ""),
           let youngModulus = Double(textFieldYoungModulus.text?.replacingOccurrences(of: ",", with: ".") ?? "") {
            let calculationResult = deflectionCalculationUseCase.calculate(lenght: lenght, width: width, height: height, pointLoad: pointLoad, youngModulus: youngModulus)
            coordinator?.navigateToCalculationResult(calculationResult: calculationResult)
        } else {
            showError(title: "Warning", message: "Invalid Inputs")
        }
    }
    
}
