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
  var sceneSwitcher: SceneSwitcherType?

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func login() {
    self.setComponentsEnabled(false)
    let username = self.usernameField.text
    let password = self.passwordField.text

    self.authService?.login(username: username, password: password) { result in
      self.setComponentsEnabled(true)
      switch result {
      case .success:
        self.sceneSwitcher?.presentProfile()

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

  private func setComponentsEnabled(_ isEnabled: Bool) {
    self.usernameField.isEnabled = isEnabled
    self.passwordField.isEnabled = isEnabled
    self.loginButton.isEnabled = isEnabled
    self.joinButton.isEnabled = isEnabled
  }
}

struct LoginStoryboard {
  let authService: AuthServiceType
  let sceneSwitcher: SceneSwitcherType

  func initialViewController() -> UIViewController? {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let navigationController = storyboard.instantiateInitialViewController() as? UINavigationController
    let loginViewController = navigationController?.topViewController as? LoginViewController
    loginViewController?.authService = self.authService
    loginViewController?.sceneSwitcher = self.sceneSwitcher
    return navigationController
  }
}
