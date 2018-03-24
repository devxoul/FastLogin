//
//  StubAuthService.swift
//  FastLoginTests
//
//  Created by Suyeol Jeon on 18/03/2018.
//  Copyright © 2018 Suyeol Jeon. All rights reserved.
//

@testable import FastLogin

final class StubAuthService: AuthServiceType {
  var stubbedLoginResult: LoginResult?
  var isLoginExecuted: Bool = false

  func login(username: String?, password: String?, completion: @escaping (LoginResult) -> Void) {
    self.isLoginExecuted = true
    if let result = self.stubbedLoginResult {
      completion(result)
    }
  }
}
