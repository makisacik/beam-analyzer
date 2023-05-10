//
//  CalculationResultViewController.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 5.05.2023.
//

import UIKit
import SnapKit

final class CalculationResultViewController: UIViewController {
    
    private let labelCalculationResult: UILabel = {
        let label = UILabel()
        label.text = "Maximum deflection result:"
        label.font = UIFont.getAppFont(withSize: 17)
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
        view.addSubview(labelCalculationResult)
        view.addSubview(shareButton)
        labelCalculationResult.text = "Maximum deflection result: \(deflectionCalculation.result)"
    }
    
    private func makeConstraints() {
        labelCalculationResult.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        shareButton.snp.makeConstraints { make in
            make.top.equalTo(labelCalculationResult.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(35)
        }
        
    }
    
    @objc private func didTapShareButton() {
        let conversationsVC = ConversationsViewController(deflectionCalculation: deflectionCalculation)
        self.present(conversationsVC, animated: true)
        print("didTapShareButton")
    }
    
}
