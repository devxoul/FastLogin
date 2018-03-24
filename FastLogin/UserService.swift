//
//  UserService.swift
//  FastLogin
//
//  Created by Suyeol Jeon on 18/03/2018.
//  Copyright © 2018 Suyeol Jeon. All rights reserved.
//

import Alamofire
import CodableAlamofire

protocol UserServiceType {
  func currentUser(completion: @escaping (Result<String>) -> Void)
}

final class UserService: UserServiceType {
  static let shared = UserService()

  func currentUser(completion: @escaping (Result<String>) -> Void) {
    Alamofire.request("https://httpbin.org/get?username=fast", method: .get)
      .validate()
      .responseDecodableObject(keyPath: "args") { (response: DataResponse<CurrentUserResponse>) in
        let result = response.result.map { $0.username }
        completion(result)
      }
  }
}

private struct CurrentUserResponse: Decodable {
  let username: String
}
