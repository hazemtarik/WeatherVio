//
//  AppDelegate.swift
//  WeaterVio
//
//  Created by Hazem Tarek on 8/19/20.
//  Copyright © 2020 Hazem Tarek. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        checkDefaultSettings()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }

    

    // MARK:- Check unit
    private func checkDefaultSettings() {
        guard let _ = user_default.unit else {
            UserDefaults.standard.setValue(units.Celsius.rawValue, forKey: userDefaultsKeys.unit)
            return
        }
        guard let _ = user_default.color else {
            UserDefaults.standard.set("0", forKey: userDefaultsKeys.color)
            return
        }
    }
    
}

