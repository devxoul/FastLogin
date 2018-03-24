//
//  SceneSwitcher.swift
//  FastLogin
//
//  Created by Suyeol Jeon on 24/03/2018.
//  Copyright © 2018 Suyeol Jeon. All rights reserved.
//

import UIKit

final class SceneSwitcher {
  let window: UIWindow?
  var authService: AuthServiceType?
  var userService: UserServiceType?

  init(window: UIWindow?) {
    self.window = window
  }

  func presentLogin() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let navigationController = storyboard.instantiateInitialViewController() as? UINavigationController
    let loginViewController = navigationController?.topViewController as? LoginViewController
    loginViewController?.authService = self.authService
    loginViewController?.sceneSwitcher = self
    self.window?.rootViewController = navigationController
  }

  func presentProfile() {
    let storyboard = UIStoryboard(name: "Profile", bundle: nil)
    let navigationController = storyboard.instantiateInitialViewController() as? UINavigationController
    let profileViewController = navigationController?.topViewController as? ProfileViewController
    profileViewController?.userService = self.userService
    self.window?.rootViewController = navigationController
  }
}
