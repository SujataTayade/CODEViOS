//
//  AppDelegate.swift
//  CODEViOS
//
//  Created by Sujata Tayade on 24/07/20.
//  Copyright © 2020 Sujata Tayade. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let navigationBarAppearace = UINavigationBar.appearance()
        
        navigationBarAppearace.tintColor = UIColor.white
        //navigationBarAppearace.barTintColor = UIColor(patternImage: UIImage(named: "bgv")!)
        navigationBarAppearace.barTintColor = UIColor.white
        navigationBarAppearace.backgroundColor = UIColor.white
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        if let topViewController = presentedViewController{
            return topViewController.preferredStatusBarStyle
        }
        if let topViewController = viewControllers.last {
            return topViewController.preferredStatusBarStyle
        }

        return .default
    }
}
