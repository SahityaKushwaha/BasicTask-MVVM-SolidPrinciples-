//
//  AppDelegate.swift
//  Task
//
//  Created by sahitya kushwaha on 08/03/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var reachability = Reachability()!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupReachability()
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

extension AppDelegate {
    //Network rechability
    func setupReachability() {
        logInfo("setupReachability")
        // Allocate a reachability object
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                logInfo("Reachable via WiFi")
            } else {
                logInfo("Reachable via Cellular")
            }
            isInternetAvailale = true
        }
        reachability.whenUnreachable = { _ in
            logInfo("Not reachable")
            isInternetAvailale = false
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            logInfo("Unable to start notifier")
        }
    }
}
