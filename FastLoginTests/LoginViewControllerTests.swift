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
    // given
    _ = self.viewController.view // loadView

    let authService = StubAuthService()
    authService.stubbedLoginResult = .success
    self.viewController.authService = authService

    // when
    self.viewController.login()

    // then
    let window = UIApplication.shared.windows.first
    let navigationController = window?.rootViewController as? UINavigationController
    let rootViewController = navigationController?.viewControllers.first
    XCTAssert(rootViewController is ProfileViewController)
  }

  func testLoginFailure_wrongUsername_presentAlertController() {
    // given
    _ = self.viewController.view // loadView

    let authService = StubAuthService()
    authService.stubbedLoginResult = .failure(.wrongUsername)
    self.viewController.authService = authService

    // when
    self.viewController.login()

    // then
    let alertController = self.viewController.presentedViewController as? UIAlertController
    XCTAssertNotNil(alertController)
    XCTAssert(alertController?.message?.lowercased().contains("no such user") == true)
  }

  func testLoginFailure_wrongPassword_presentAlertController() {
    // given
    _ = self.viewController.view // loadView

    let authService = StubAuthService()
    authService.stubbedLoginResult = .failure(.wrongPassword)
    self.viewController.authService = authService

    // when
    self.viewController.login()

    // then
    let alertController = self.viewController.presentedViewController as? UIAlertController
    XCTAssertNotNil(alertController)
    XCTAssert(alertController?.message?.lowercased().contains("wrong password") == true)
  }

  func testJoinButton_pushCreateAccountViewController() {
    _ = self.viewController.view // loadView

    let segueTemplates = self.viewController.value(forKey: "_storyboardSegueTemplates") as? [AnyObject]
    let segueTemplate = segueTemplates?.first as AnyObject

    let buttonTargetActions = self.viewController.joinButton.value(forKey: "_targetActions") as? [AnyObject]
    let buttonTarget = buttonTargetActions?.first?.value(forKey: "_target") as AnyObject

    XCTAssertEqual(NSStringFromClass(type(of: segueTemplate)), "UIStoryboardShowSegueTemplate")
    XCTAssertTrue(segueTemplate === buttonTarget)
  }
}
