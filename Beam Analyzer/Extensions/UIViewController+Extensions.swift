//
//  UIViewController+Extensions.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 13.02.2023.
//

import UIKit

extension UIViewController {
  func showLoadingIndicator() -> UIActivityIndicatorView {
    let activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.center = view.center
    activityIndicator.hidesWhenStopped = true
    view.addSubview(activityIndicator)
    activityIndicator.startAnimating()
    return activityIndicator
  }

  func stopLoadingIndicator(activityIndicator: UIActivityIndicatorView?) {
      if let activityIndicator {
          activityIndicator.stopAnimating()
          activityIndicator.removeFromSuperview()
      }
  }
}
