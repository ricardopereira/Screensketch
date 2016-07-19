//
//  AppDelegate.swift
//  Screensketch
//
//  Created by Ricardo Pereira on 17/07/16.
//  Copyright © 2016 Ricardo Pereira. All rights reserved.
//

import UIKit

struct Device {
    static var isSimulator: Bool {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            return true
        #else
            return false
        #endif
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = ImagesViewController()
        return true
    }

    func applicationDidBecomeActive(application: UIApplication) {
        if let viewController = window?.rootViewController as? ViewControllerAccessPrivacy {
            viewController.verifyPermissions()
        }
    }

}
