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
    }
    
    private func makeConstraints() {
        stackViewCalculationInputs.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide).inset(60)
        }
        textFieldLenghtOfBeam.snp.makeConstraints { make in
            make.width.equalTo(60)
        }
    }
    
}
