//
//  AppDelegate.swift
//  test
//
//  Created by Alexey Kuznetsov on 09.03.2021.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navVC = UINavigationController(rootViewController: ViewController())
        navVC.navigationBar.isHidden = true
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        return true
    }
}

