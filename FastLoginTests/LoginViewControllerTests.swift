//
//  LoginViewControllerTests.swift
//  FastLoginTests
//
//  Created by Suyeol Jeon on 18/03/2018.
//  Copyright © 2018 Suyeol Jeon. All rights reserved.
//

import XCTest
@testable import FastLogin

class LoginViewControllerTests: XCTestCase {
  var viewController: LoginViewController!

  override func setUp() {
    super.setUp()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let navigationController = storyboard.instantiateInitialViewController() as? UINavigationController
    self.viewController = navigationController?.viewControllers.first as? LoginViewController
    UIApplication.shared.windows.first?.rootViewController = navigationController
  }

  func testLoginSuccess_changeWindowRootViewController() {
  }

  func testLoginFailure_wrongUsername_presentAlertController() {
  }

  func testLoginFailure_wrongPassword_presentAlertController() {
  }
}
