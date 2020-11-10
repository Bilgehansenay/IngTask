//
//  AppDelegate.swift
//  Ing Task
//
//  Created by Bilgehan Senay on 6.11.2020.
//  Copyright © 2020 Bilgehan Senay. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        return true
    }

}

