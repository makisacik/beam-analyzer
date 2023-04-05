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
        disableUserInterraction()
    }
    
    func hideLoadingAnimation() {
        view.subviews.filter { $0 is NVActivityIndicatorView }.forEach { $0.removeFromSuperview() }
        activateUserInterraction()
    }
    
    func showError(title: String? = "Database Error", message: String? = "An error occurred.") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)
    }
 
    private func disableUserInterraction() {
        self.view.isUserInteractionEnabled = false
        navigationController?.navigationBar.isUserInteractionEnabled = false
    }
    
    private func activateUserInterraction() {
        self.view.isUserInteractionEnabled = true
        navigationController?.navigationBar.isUserInteractionEnabled = true
    }
}
