//
//  SceneDelegate.swift
//  MyProfile
//
//  Created by Gilang Ramadhan on 19/06/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  let storyboard = UIStoryboard(name: "Main", bundle: nil)

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {

    guard let windowScene = scene as? UIWindowScene else { return }

    let initialViewController: UIViewController?

    window = UIWindow(windowScene: windowScene)
    if ProfileModel.stateLogin {
      initialViewController = storyboard
        .instantiateViewController(withIdentifier: "HomeScene") as? HomeViewController
    } else {
      initialViewController = storyboard
        .instantiateViewController(withIdentifier: "CreateScene") as? CreateViewController
    }

    window?.rootViewController = initialViewController
    window?.makeKeyAndVisible()
  }

}
