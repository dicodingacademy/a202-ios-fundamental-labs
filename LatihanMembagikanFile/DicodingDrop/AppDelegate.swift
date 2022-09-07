//
//  AppDelegate.swift
//  DicodingDrop
//
//  Created by Gilang Ramadhan on 30/06/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller = ViewController()

    let navigation = UINavigationController(rootViewController: controller)

    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = navigation
    window?.makeKeyAndVisible()

    return true
  }

  func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey: Any] = [:]
  ) -> Bool {
    guard url.pathExtension == "dicoding",
          let data = try? Data(contentsOf: url),
          let navigation = window?.rootViewController as? UINavigationController
    else { return false }

    let controller = ResultViewController(data: data)

    navigation.pushViewController(controller, animated: true)

    try? FileManager.default.removeItem(at: url)

    return true
  }
}
