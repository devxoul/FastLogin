//
//  SceneSwitcherTests.swift
//  FastLoginTests
//
//  Created by Suyeol Jeon on 24/03/2018.
//  Copyright © 2018 Suyeol Jeon. All rights reserved.
//

import XCTest
@testable import FastLogin

final class SceneSwitcherTests: XCTestCase {
  var window: UIWindow!
  var sceneSwitcher: SceneSwitcher!

  override func setUp() {
    super.setUp()
    self.window = UIWindow()
    self.sceneSwitcher = SceneSwitcher(window: self.window)
    self.sceneSwitcher.loginStoryboard = LoginStoryboard(authService: StubAuthService(), sceneSwitcher: self.sceneSwitcher)
    self.sceneSwitcher.profileStoryboard = ProfileStoryboard(userService: StubUserService(), sceneSwitcher: self.sceneSwitcher)
  }

  func testPresentLogin() {
    // when
    self.sceneSwitcher.presentLogin()

    // then
    let navigationController = self.window?.rootViewController as? UINavigationController
    let rootViewController = navigationController?.viewControllers.first
    XCTAssert(rootViewController is LoginViewController)
  }

  func testPresentProfile() {
    // when
    self.sceneSwitcher.presentProfile()

    // then
    let navigationController = self.window?.rootViewController as? UINavigationController
    let rootViewController = navigationController?.viewControllers.first
    XCTAssert(rootViewController is ProfileViewController)
  }
}
