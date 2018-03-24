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
  var loginStoryboard: LoginStoryboard?
  var profileStoryboard: ProfileStoryboard?

  init(window: UIWindow?) {
    self.window = window
  }

  func presentLogin() {
    self.window?.rootViewController = self.loginStoryboard?.initialViewController()
  }

  func presentProfile() {
    self.window?.rootViewController = self.profileStoryboard?.initialViewController()
  }
}
