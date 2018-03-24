//
//  ProfileViewController.swift
//  FastLogin
//
//  Created by Suyeol Jeon on 18/03/2018.
//  Copyright © 2018 Suyeol Jeon. All rights reserved.
//

import UIKit

final class ProfileViewController: UIViewController {
  @IBOutlet var welcomeLabel: UILabel!

  var userService: UserServiceType?
  var sceneSwitcher: SceneSwitcher?

  override func viewDidLoad() {
    super.viewDidLoad()

    self.userService?.currentUser { result in
      switch result {
      case let .success(username):
        self.welcomeLabel.text = "Welcome, \(username)!"

      case .failure:
        self.welcomeLabel.text = "Error!"
      }
    }
  }

  @IBAction private func logout() {
    self.sceneSwitcher?.presentLogin()
  }
}
