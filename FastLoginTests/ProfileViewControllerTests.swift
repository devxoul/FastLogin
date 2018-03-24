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

  func testActivityIndicatorView_isVisible_whileLoading() {
    // given
    let userService = StubUserService()
    userService.stubbedCurrentUserResult = nil
    self.viewController.userService = userService

    // when
    _ = self.viewController.view // loadView

    // then
    XCTAssertFalse(self.viewController.activityIndicatorView.isHidden)
  }

  func testActivityIndicatorView_isHidden_afterLoadingSuccess() {
    // given
    let userService = StubUserService()
    userService.stubbedCurrentUserResult = .success("")
    self.viewController.userService = userService

    // when
    _ = self.viewController.view // loadView

    // then
    XCTAssertTrue(self.viewController.activityIndicatorView.isHidden)
  }

  func testActivityIndicatorView_isHidden_afterLoadingFailure() {
    // given
    let userService = StubUserService()
    userService.stubbedCurrentUserResult = .failure(NSError())
    self.viewController.userService = userService

    // when
    _ = self.viewController.view // loadView

    // then
    XCTAssertTrue(self.viewController.activityIndicatorView.isHidden)
  }

  func testWelcomeLabel_isHidden_whileLoading() {
    // given
    let userService = StubUserService()
    userService.stubbedCurrentUserResult = nil
    self.viewController.userService = userService

    // when
    _ = self.viewController.view // loadView

    // then
    XCTAssertTrue(self.viewController.welcomeLabel.isHidden)
  }

  func testWelcomeLabel_isVisible_afterLoadingSuccess() {
    // given
    let userService = StubUserService()
    userService.stubbedCurrentUserResult = .success("")
    self.viewController.userService = userService

    // when
    _ = self.viewController.view // loadView

    // then
    XCTAssertFalse(self.viewController.welcomeLabel.isHidden)
  }

  func testWelcomeLabel_isVisible_afterLoadingFailure() {
    // given
    let userService = StubUserService()
    userService.stubbedCurrentUserResult = .failure(NSError())
    self.viewController.userService = userService

    // when
    _ = self.viewController.view // loadView

    // then
    XCTAssertFalse(self.viewController.welcomeLabel.isHidden)
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

  func testLogoutButton_isHidden_whileLoading() {
    // given
    let userService = StubUserService()
    userService.stubbedCurrentUserResult = nil
    self.viewController.userService = userService

    // when
    _ = self.viewController.view // loadView

    // then
    XCTAssertTrue(self.viewController.logoutButton.isHidden)
  }

  func testLogoutButton_isVisible_afterLoadingSuccess() {
    // given
    let userService = StubUserService()
    userService.stubbedCurrentUserResult = .success("")
    self.viewController.userService = userService

    // when
    _ = self.viewController.view // loadView

    // then
    XCTAssertFalse(self.viewController.logoutButton.isHidden)
  }

  func testLogoutButton_isVisible_afterLoadingFailure() {
    // given
    let userService = StubUserService()
    userService.stubbedCurrentUserResult = .failure(NSError())
    self.viewController.userService = userService

    // when
    _ = self.viewController.view // loadView

    // then
    XCTAssertFalse(self.viewController.logoutButton.isHidden)
  }

  func testLogoutButton_changeWindowRootViewController() {
    // given
    let sceneSwitcher = SpySceneSwitcher()
    self.viewController.sceneSwitcher = sceneSwitcher
    _ = self.viewController.view

    // when
    self.viewController.logoutButton.sendActions(for: .touchUpInside)

    // then
    XCTAssertTrue(sceneSwitcher.isLoginPresented)
  }
}
