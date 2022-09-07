//
//  SceneDelegate.swift
//  MemberDicoding
//
//  Created by Gilang Ramadhan on 24/06/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    if !UserDefaults.standard.bool(forKey: "first") {
      MemberProvider().addMemberDummy() {
        UserDefaults.standard.set(true, forKey: "first")
      }
    }
  }
}
