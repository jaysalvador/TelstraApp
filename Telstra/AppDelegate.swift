//
//  AppDelegate.swift
//  Telstra
//
//  Created by Jay Salvador on 2/4/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit
import Kingfisher

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties
    
    var window: UIWindow?
    
    class var shared: AppDelegate? {
        
        return UIApplication.shared.delegate as? AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Image Cache
        
        let cache = ImageCache.default

        cache.clearMemoryCache()
        cache.clearDiskCache { print("clearDiskCache") }
        
        // MARK: - UI
        
        self.window = UIWindow(frame: UIScreen.main.bounds)

        let nav = UINavigationController(rootViewController: ViewController())
                
        self.window?.rootViewController = nav
        
        self.window?.makeKeyAndVisible()
        
        return true
    }

}
