//
//  AppDelegate.swift
//  Daver_iOS_V1
//
//  Created by 김상금 on 2022/08/30.
//

import UIKit
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        setFCM(application)
        Thread.sleep(forTimeInterval: 1.6)
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }

    // MARK: UISceneSession Lifecycle

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(
        _ application: UIApplication,
        didDiscardSceneSessions sceneSessions: Set<UISceneSession>
    ) {
        
    }


}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        if #available(iOS 14.0, *) {
            return [.badge, .sound, .list, .banner]
        } else {
            return [.alert, .badge, .sound]
        }
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        return
    }
}


private extension AppDelegate {
    func setFCM(_ application: UIApplication) {
        UNUserNotificationCenter.current().delegate = self
        let authOption: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOption, completionHandler: { _,_ in } )
        application.registerForRemoteNotifications()
    }
}
