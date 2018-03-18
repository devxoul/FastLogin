//
//  Authenticator.swift
//  FastLogin
//
//  Created by Suyeol Jeon on 18/03/2018.
//  Copyright © 2018 Suyeol Jeon. All rights reserved.
//

import Alamofire
import CodableAlamofire

enum LoginResult {
  case success
  case failure(LoginError)
}

enum LoginError: Error {
  case wrongUsername
  case wrongPassword
}

protocol AuthServiceType {
  func login(username: String?, password: String?, completion: @escaping (LoginResult) -> Void)
}

final class AuthService: AuthServiceType {
  static let shared = AuthService()

  func login(username: String?, password: String?, completion: @escaping (LoginResult) -> Void) {
    guard let username = username, !username.isEmpty else { return completion(.failure(.wrongUsername)) }
    guard let password = password, !password.isEmpty else { return completion(.failure(.wrongPassword)) }

    let parameters: Parameters = [
      "username": username,
      "password": password,
    ]

    Alamofire.request("https://httpbin.org/post", method: .post, parameters: parameters)
      .validate()
      .responseDecodableObject(keyPath: "form") { (response: DataResponse<LoginResponse>) in
        let credential = response.value.map { ($0.username, $0.password) }
        switch credential {
        case ("fast", "campus")?:
          completion(.success)

        case ("fast", _)?:
          completion(.failure(.wrongPassword))

        default:
          completion(.failure(.wrongUsername))
        }
      }
  }
}

private struct LoginResponse: Decodable {
  let username: String
  let password: String
}
