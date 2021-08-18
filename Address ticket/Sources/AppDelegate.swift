//
//  AppDelegate.swift
//  Address ticket
//
//  Created by Pedro Léda on 21/07/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)

        let viewController: UIViewController
        
        viewController = AddressViewController()

        let navViewController = UINavigationController(rootViewController: viewController)
        navViewController.isNavigationBarHidden = false
        window?.rootViewController = navViewController
        window?.makeKeyAndVisible()

        return true
    }

}

