//
//  AppDelegate.swift
//  appsflyer_hello_world
//
//  Created by user188841 on 2/9/21.
//

import UIKit
import AppsFlyerLib

@main
class AppDelegate: UIResponder, UIApplicationDelegate, AppsFlyerLibDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        AppsFlyerLib.shared().appsFlyerDevKey = "DTwSU4R6E7HVaEomY37PN8"
        AppsFlyerLib.shared().appleAppID = "1111154321"
        AppsFlyerLib.shared().delegate = self
        AppsFlyerLib.shared().isDebug = true
        NotificationCenter.default.addObserver(self,
            selector: NSSelectorFromString("sendLaunch"),
            name: UIApplication.didBecomeActiveNotification,
            object: nil)
        return true
    }
    @objc func sendLaunch() {
        AppsFlyerLib.shared().start()
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
    
    func onConversionDataSuccess(_ installData: [AnyHashable : Any]) {
        print("onConversionDataSuccess data:")
        for (key, value) in installData {
            print(key, ":", value)
        }
        if let status = installData["af_status"] as? String {
            if (status == "Non-organic") {
                if let sourceID = installData["media_source"],
                   let campaign = installData["campaign"] {
                    print("This is a Non-Organic install. Media source: \(sourceID) Campaign: \(campaign)")
                } else {
                    print("This is an organic install")
                }
                if let is_first_launch = installData["is_first_launch"] as? Bool,
                   is_first_launch {
                    print("First Launch")
                } else {
                    print("Not First Launch")
                }
            }
        }
    }
    
    func onConversionDataFail(_ error: Error!) {
        if let err = error{
            print(err)
        }
    }
    
    func onAppOpenAttribution(_ attributionData: [AnyHashable : Any]!) {
        if let data = attributionData{
            print("\(data)")
        }
    }
    
    func onAppOpenAttributionFailure(_ error: Error!) {
        if let err = error{
            print(err)
        }
    }


}

