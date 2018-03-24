//
//  StubUserService.swift
//  FastLoginTests
//
//  Created by Suyeol Jeon on 24/03/2018.
//  Copyright © 2018 Suyeol Jeon. All rights reserved.
//

import Alamofire
@testable import FastLogin

final class StubUserService: UserServiceType {
  var stubbedCurrentUserResult: Result<String>?

  func currentUser(completion: @escaping (Result<String>) -> Void) {
    if let result = self.stubbedCurrentUserResult {
      completion(result)
    }
  }
}
