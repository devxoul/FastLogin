//
//  ViewController.swift
//  FastLogin
//
//  Created by Suyeol Jeon on 17/03/2018.
//  Copyright © 2018 Suyeol Jeon. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  @IBOutlet var usernameField: UITextField!
  @IBOutlet var passwordField: UITextField!
  @IBOutlet var loginButton: UIButton!
  @IBOutlet var joinButton: UIButton!

  var authService: AuthServiceType?

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func login() {
    let username = self.usernameField.text
    let password = self.passwordField.text

    self.authService?.login(username: username, password: password) { result in
      switch result {
      case .success:
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let window = UIApplication.shared.windows.first
        window?.rootViewController = storyboard.instantiateInitialViewController()

      case .failure(.wrongUsername):
        let message = "No such user"
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)

      case .failure(.wrongPassword):
        let message = "Wrong password"
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
      }
    }
  }
}
