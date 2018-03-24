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

  func testUsernameField_hasPlaceholder() {
    _ = self.viewController.view // loadView
    XCTAssertNotNil(self.viewController.usernameField.placeholder)
  }

  func testPasswordField_hasPlaceholder() {
    _ = self.viewController.view // loadView
    XCTAssertNotNil(self.viewController.passwordField.placeholder)
  }

  func testPasswordField_secureTextEntry() {
    _ = self.viewController.view // loadView
    XCTAssertTrue(viewController.passwordField.isSecureTextEntry)
  }

  func testLogin_disableComponentsWhileLoading() {
    // given
    let authService = StubAuthService()
    authService.stubbedLoginResult = nil
    self.viewController.authService = authService
    _ = self.viewController.view // loadView

    // when
    self.viewController.login()

    // then
    XCTAssertFalse(self.viewController.usernameField.isEnabled)
    XCTAssertFalse(self.viewController.passwordField.isEnabled)
    XCTAssertFalse(self.viewController.loginButton.isEnabled)
    XCTAssertFalse(self.viewController.joinButton.isEnabled)
  }

  func testLogin_enableComponentsAfterLoading() {
    // given
    let authService = StubAuthService()
    authService.stubbedLoginResult = .failure(.wrongPassword)
    self.viewController.authService = authService
    _ = self.viewController.view // loadView

    // when
    self.viewController.login()

    // then
    XCTAssertTrue(self.viewController.usernameField.isEnabled)
    XCTAssertTrue(self.viewController.passwordField.isEnabled)
    XCTAssertTrue(self.viewController.loginButton.isEnabled)
    XCTAssertTrue(self.viewController.joinButton.isEnabled)
  }

  func testLoginSuccess_changeWindowRootViewController() {
    // given
    let sceneSwitcher = SpySceneSwitcher()
    self.viewController.sceneSwitcher = sceneSwitcher
    _ = self.viewController.view // loadView

    let authService = StubAuthService()
    authService.stubbedLoginResult = .success
    self.viewController.authService = authService

    // when
    self.viewController.login()

    // then
    XCTAssertTrue(sceneSwitcher.isProfilePresented)
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
