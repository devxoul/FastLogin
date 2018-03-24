//
//  ProfileViewControllerTests.swift
//  FastLoginTests
//
//  Created by Suyeol Jeon on 18/03/2018.
//  Copyright © 2018 Suyeol Jeon. All rights reserved.
//

import XCTest
@testable import FastLogin

final class ProfileViewControllerTests: XCTestCase {
  var viewController: ProfileViewController!

  override func setUp() {
    super.setUp()
    let storyboard = UIStoryboard(name: "Profile", bundle: nil)
    let navigationController = storyboard.instantiateInitialViewController() as? UINavigationController
    self.viewController = navigationController?.viewControllers.first as? ProfileViewController
    UIApplication.shared.windows.first?.rootViewController = navigationController
  }

  func testWelcomeLabel_presentUsername() {
    // when
    _ = self.viewController.view // loadView

    // wait
    let expectation = XCTestExpectation()
    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: expectation.fulfill)
    XCTWaiter().wait(for: [expectation], timeout: 3)

    // then
    XCTAssert(viewController.welcomeLabel.text?.contains("fast") == true)
  }

  func testLogoutButton_changeWindowRootViewController() {
    // given
    let logoutButton = viewController.view.subviews
      .flatMap { $0 as? UIButton }
      .first { $0.title(for: .normal) == "Sign out" }

    // when
    logoutButton?.sendActions(for: .touchUpInside)

    // then
    let window = UIApplication.shared.windows.first
    let navigationController = window?.rootViewController as? UINavigationController
    let rootViewController = navigationController?.viewControllers.first
    XCTAssert(rootViewController is LoginViewController)
  }
}
