//
//  ResultGraphMarker.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 13.04.2023.
//

import UIKit
import Charts
import SnapKit

class ResultsGraphMarker: MarkerView {
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.text = "Value"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let registerCardView: CardView = {
        let cardView = CardView()
        cardView.backgroundColor = .lightGray
        cardView.cornerRadius = 5
        cardView.shadowColor = .label
        return cardView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func setValues(xValue: Double, yValue: Double) {
        valueLabel.text = String(format: "X: %.1f\nY: %.1f", xValue, yValue)
    }
    
    private func setupViews() {
        self.addSubview(contentView)
        contentView.addSubview(registerCardView)
        registerCardView.addSubview(valueLabel)
        self.backgroundColor = .clear
        self.frame = CGRect(x: 0, y: 0, width: 65, height: 40)
        self.offset = CGPoint(x: -(self.frame.width/2), y: -self.frame.height)
        
        contentView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        registerCardView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        valueLabel.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview().inset(3)
        }
        
        layoutIfNeeded()
    }

}
