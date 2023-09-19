//
//  AppDelegate.swift
//  ShooterGame
//
//  Created by Аня Воронцова on 13.09.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UINavigationController(rootViewController: StartViewController())  
        window.makeKeyAndVisible()
        self.window = window
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {    }

    func applicationDidEnterBackground(_ application: UIApplication) {    }

    func applicationWillEnterForeground(_ application: UIApplication) {    }

    func applicationDidBecomeActive(_ application: UIApplication) {    }

}
