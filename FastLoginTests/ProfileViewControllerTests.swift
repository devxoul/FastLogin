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

  func testWelcomeLabel_presentUsername_whenFetchingCurrentUserSuccess() {
    // given
    let userService = StubUserService()
    userService.stubbedCurrentUserResult = .success("devxoul")
    self.viewController.userService = userService

    // when
    _ = self.viewController.view // loadView

    // then
    XCTAssert(viewController.welcomeLabel.text?.contains("devxoul") == true)
  }

  func testWelcomeLabel_presentErrorMessage_whenFetchingCurrentUserFailure() {
    // given
    let userService = StubUserService()
    userService.stubbedCurrentUserResult = .failure(NSError())
    self.viewController.userService = userService

    // when
    _ = self.viewController.view // loadView

    // then
    XCTAssert(viewController.welcomeLabel.text?.contains("Error") == true)
  }

  func testLogoutButton_changeWindowRootViewController() {
    // given
    let sceneSwitcher = SpySceneSwitcher()
    self.viewController.sceneSwitcher = sceneSwitcher
    let logoutButton = viewController.view.subviews
      .flatMap { $0 as? UIButton }
      .first { $0.title(for: .normal) == "Sign out" }

    // when
    logoutButton?.sendActions(for: .touchUpInside)

    // then
    XCTAssertTrue(sceneSwitcher.isLoginPresented)
  }
}
