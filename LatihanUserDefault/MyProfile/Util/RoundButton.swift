//
//  RoundedButton.swift
//  MyProfile
//
//  Created by Gilang Ramadhan on 19/06/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {

  @IBInspectable var cornerRadius: CGFloat = 0 {
    didSet {
      self.layer.cornerRadius = cornerRadius
    }
  }

  @IBInspectable var borderWidth: CGFloat = 0 {
    didSet {
      self.layer.borderWidth = borderWidth
    }
  }

  @IBInspectable var borderColor: UIColor = UIColor.clear {
    didSet {
      self.layer.borderColor = borderColor.cgColor
    }
  }

  func pinkColor() {
    self.backgroundColor = UIColor(red: 255/255, green: 85/255, blue: 131/255, alpha: 1)
    self.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: .normal)
  }

  func whiteColor() {
    self.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    self.setTitleColor(UIColor(red: 45/255, green: 62/255, blue: 80/255, alpha: 1), for: .normal)
  }
}
