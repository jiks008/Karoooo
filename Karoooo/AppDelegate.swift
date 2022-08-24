//
//  AppDelegate.swift
//  Karoooo
//
//  Created by Jignesh Vadadoriya on 22/08/22.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // IQKeyboardManager.shared.enable = true
        
        window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        return true
    }
    
    
}

