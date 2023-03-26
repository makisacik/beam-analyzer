//
//  UIViewController+Extensions.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 13.02.2023.
//

import UIKit
import NVActivityIndicatorView

extension UIViewController {
    
    func showLoadingAnimation() {
        let activityIndicator = NVActivityIndicatorView(frame: .zero, type: .ballPulse, color: .label)
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(50)
        }
        activityIndicator.startAnimating()
    }
    
    func hideLoadingAnimation() {
        view.subviews.filter { $0 is NVActivityIndicatorView }.forEach { $0.removeFromSuperview() }
    }
}
