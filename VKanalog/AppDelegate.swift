//
//  AppDelegate.swift
//  VKanalog
//
//  Created by qwerty on 01.02.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow()
        window.rootViewController = ViewController()
        window.makeKeyAndVisible()
        self.window = window
        
    return true
    }
    
}
