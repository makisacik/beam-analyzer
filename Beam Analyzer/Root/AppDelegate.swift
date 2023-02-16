//
//  AppDelegate.swift
//  Beam Analyzer
//
//  Created by Mehmet Ali Kısacık on 5.02.2023.
//

import UIKit
import CoreData
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }

}
