//
//  CalculationResultViewController.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 5.05.2023.
//

import UIKit
import SnapKit

final class CalculationResultViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    private let calculationResult: Double
    
    private let labelCalculationResult: UILabel = {
        let label = UILabel()
        label.text = "Maximum deflection result:"
        label.font = UIFont.getAppFont(withSize: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    init(calculationResult: Double) {
        self.calculationResult = calculationResult
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
        view.addSubview(labelCalculationResult)
        labelCalculationResult.text = "Maximum deflection result: \(calculationResult)"
    }
    
    private func makeConstraints() {
        labelCalculationResult.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
    }
    
}
