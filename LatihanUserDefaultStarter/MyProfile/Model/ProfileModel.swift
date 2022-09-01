//
//  UserModel.swift
//  MyProfile
//
//  Created by Gilang Ramadhan on 19/06/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import Foundation

struct ProfileModel {
  static let stateLoginKey = "state"
  static let nameKey = "name"
  static let emailKey = "email"
  static let professionKey = "profession"

  static var stateLogin: Bool {
    get {
      return UserDefaults.standard.bool(forKey: stateLoginKey)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: stateLoginKey)
    }
  }

  static var name: String {
    get {
      return UserDefaults.standard.string(forKey: nameKey) ?? ""
    }
    set {
      UserDefaults.standard.set(newValue, forKey: nameKey)
    }
  }

  static var email: String {
    get {
      return UserDefaults.standard.string(forKey: emailKey) ?? ""
    }
    set {
      UserDefaults.standard.set(newValue, forKey: emailKey)
    }
  }

  static var profession: String {
    get {
      return UserDefaults.standard.string(forKey: professionKey) ?? ""
    }
    set {
      UserDefaults.standard.set(newValue, forKey: professionKey)
    }
  }

  static func deteleAll() -> Bool {
    if let domain = Bundle.main.bundleIdentifier {
      UserDefaults.standard.removePersistentDomain(forName: domain)
      UserDefaults.standard.synchronize()
      return true
    } else { return false }
  }
}
