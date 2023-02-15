//
//  UILabel+Extensions.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 13.02.2023.
//

import UIKit

extension UILabel {
    func shake() {
      let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
      animation.timingFunction = CAMediaTimingFunction(name: .linear)
      animation.duration = 0.6
      animation.values = [-15.0, 15.0, -7.0, 7.0, -2.0, 2.0, 0.0]
      layer.add(animation, forKey: "shake")
    }
}
