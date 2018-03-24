//
//  SpySceneSwitcher.swift
//  FastLoginTests
//
//  Created by Suyeol Jeon on 24/03/2018.
//  Copyright © 2018 Suyeol Jeon. All rights reserved.
//

@testable import FastLogin

final class SpySceneSwitcher: SceneSwitcherType {
  private(set) var isLoginPresented = false
  private(set) var isProfilePresented = false

  func presentLogin() {
    self.isLoginPresented = true
  }

  func presentProfile() {
    self.isProfilePresented = true
  }
}
