//
//  UIFont+Extensions.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 13.02.2023.
//

import UIKit

extension UIFont {
    static func getAppFont(withSize: Int) -> UIFont {
        return UIFont(name: "PingFang SC Regular", size: CGFloat(withSize)) ?? UIFont()
    }
    
    static func getBoldAppFont(withSize: Int) -> UIFont {
        return UIFont(name: "PingFang SC Semibold", size: CGFloat(withSize)) ?? UIFont()
    }
}
