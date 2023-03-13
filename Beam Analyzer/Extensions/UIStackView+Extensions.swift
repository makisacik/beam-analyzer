//
//  UIStackView+Extensions.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 14.03.2023.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
