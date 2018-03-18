//
//  AppDelegate.swift
//  FastLogin
//
//  Created by Suyeol Jeon on 17/03/2018.
//  Copyright © 2018 Suyeol Jeon. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    let navigationController = self.window?.rootViewController as? UINavigationController
    let loginViewController = navigationController?.viewControllers.first as? LoginViewController
    loginViewController?.authService = AuthService.shared
    return true
  }
}
