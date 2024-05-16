//
//  AppDelegate.swift
//  games
//
//  Created by Boris Bengus on 15/05/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    private lazy var di: AppContainerProtocol = AppContainer()
    

    // MARK: - UIApplicationDelegate
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if !ProcessInfo.processInfo.isiOSAppOnMac {
            // Show touches indication in Debug for iPhone and iPad
            ShowTime.enabled = .debugOnly
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = di.gameListScreenFactory()
        window?.makeKeyAndVisible()
        
        return true
    }
}

