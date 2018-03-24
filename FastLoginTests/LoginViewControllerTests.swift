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

  func testUsernameField_resetBackgroundColorWhenChangeText() {
    // given
    _ = self.viewController.view // loadView
    let originalBackgroundColor = self.viewController.usernameField.backgroundColor
    self.viewController.usernameField.backgroundColor = .yellow

    // when
    self.viewController.usernameField.sendActions(for: .editingChanged)

    // then
    XCTAssert(self.viewController.usernameField.backgroundColor == originalBackgroundColor)
  }

  func testPasswordField_hasPlaceholder() {
    _ = self.viewController.view // loadView
    XCTAssertNotNil(self.viewController.passwordField.placeholder)
  }

  func testPasswordField_secureTextEntry() {
    _ = self.viewController.view // loadView
    XCTAssertTrue(viewController.passwordField.isSecureTextEntry)
  }

  func testPasswordField_resetBackgroundColorWhenChangeText() {
    // given
    _ = self.viewController.view // loadView
    let originalBackgroundColor = self.viewController.passwordField.backgroundColor
    self.viewController.passwordField.backgroundColor = .yellow

    // when
    self.viewController.passwordField.sendActions(for: .editingChanged)

    // then
    XCTAssert(self.viewController.passwordField.backgroundColor == originalBackgroundColor)
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

  func testLoginFailure_wrongUsername_changeBackgroundColor() {
    // given
    _ = self.viewController.view // loadView
    let originalBackgroundColor = self.viewController.usernameField.backgroundColor

    let authService = StubAuthService()
    authService.stubbedLoginResult = .failure(.wrongUsername)
    self.viewController.authService = authService

    // when
    self.viewController.login()

    // then
    XCTAssert(self.viewController.usernameField.backgroundColor != originalBackgroundColor)
  }

  func testLoginFailure_wrongUsername_becomeFirstResponder() {
    // given
    UIApplication.shared.keyWindow?.rootViewController = self.viewController

    let authService = StubAuthService()
    authService.stubbedLoginResult = .failure(.wrongUsername)
    self.viewController.authService = authService

    // when
    self.viewController.login()

    // then
    XCTAssertTrue(self.viewController.usernameField.isFirstResponder)
  }

  func testLoginFailure_wrongPassword_changeBackgroundColor() {
    // given
    _ = self.viewController.view // loadView
    let originalBackgroundColor = self.viewController.passwordField.backgroundColor

    let authService = StubAuthService()
    authService.stubbedLoginResult = .failure(.wrongPassword)
    self.viewController.authService = authService

    // when
    self.viewController.login()

    // then
    XCTAssert(self.viewController.passwordField.backgroundColor != originalBackgroundColor)
  }

  func testLoginFailure_wrongPassword_becomeFirstResponder() {
    // given
    UIApplication.shared.keyWindow?.rootViewController = self.viewController

    let authService = StubAuthService()
    authService.stubbedLoginResult = .failure(.wrongPassword)
    self.viewController.authService = authService

    // when
    self.viewController.login()

    // then
    XCTAssertTrue(self.viewController.passwordField.isFirstResponder)
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
