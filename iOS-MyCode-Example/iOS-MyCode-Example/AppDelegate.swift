//
//  AppDelegate.swift
//  iOS-MyCode-Example
//
//  Created by Zakariae El Aloussi on 18/01/2023.
//

import UIKit
import SnapKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        EnvironmentHandler.shared.initialize()
        
        return true
        
    }

}

