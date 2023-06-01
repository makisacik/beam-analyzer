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
        let activityIndicator = NVActivityIndicatorView(frame: .zero, type: .ballRotateChase, color: .label)
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
    
    func showAlert(title: String? = "Database Error", message: String? = "An error occurred.") {
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
    
    func showToast(message: String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-250, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 0.2, delay: 0.5, options: .curveEaseInOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(_) in
            toastLabel.removeFromSuperview()
        })
    }
}
