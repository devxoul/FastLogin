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
    self.viewController.usernameField.text = "fast"
    self.viewController.passwordField.text = "campus"

    // when
    self.viewController.login()

    // wait
    let expectation = XCTestExpectation()
    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: expectation.fulfill)
    XCTWaiter().wait(for: [expectation], timeout: 3)

    // then
    let window = UIApplication.shared.windows.first
    let navigationController = window?.rootViewController as? UINavigationController
    let rootViewController = navigationController?.viewControllers.first
    XCTAssert(rootViewController is ProfileViewController)
  }

  func testLoginFailure_wrongUsername_presentAlertController() {
    // given
    _ = self.viewController.view // loadView
    self.viewController.usernameField.text = "WRONG USERNAME"
    self.viewController.passwordField.text = "campus123"

    // when
    self.viewController.login()

    // wait
    let expectation = XCTestExpectation()
    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: expectation.fulfill)
    XCTWaiter().wait(for: [expectation], timeout: 3)

    // then
    let alertController = self.viewController.presentedViewController as? UIAlertController
    XCTAssertNotNil(alertController)
    XCTAssert(alertController?.message?.lowercased().contains("no such user") == true)
  }

  func testLoginFailure_wrongPassword_presentAlertController() {
    // given
    _ = self.viewController.view // loadView
    self.viewController.usernameField.text = "fast"
    self.viewController.passwordField.text = "WRONG PASSWORD"

    // when
    self.viewController.login()

    // wait
    let expectation = XCTestExpectation()
    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: expectation.fulfill)
    XCTWaiter().wait(for: [expectation], timeout: 3)

    // then
    let alertController = self.viewController.presentedViewController as? UIAlertController
    XCTAssertNotNil(alertController)
    XCTAssert(alertController?.message?.lowercased().contains("wrong password") == true)
  }
}
