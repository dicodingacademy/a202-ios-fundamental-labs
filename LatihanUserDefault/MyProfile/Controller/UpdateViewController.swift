//
//  UpdateViewController.swift
//  MyProfile
//
//  Created by Gilang Ramadhan on 19/06/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController {

  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var professionTextField: UITextField!
  @IBOutlet weak var saveButton: RoundButton!
  @IBOutlet weak var cancelButton: RoundButton!

  override func viewDidLoad() {
    super.viewDidLoad()

    saveButton.pinkColor()
    cancelButton.whiteColor()
  }

  override func viewWillAppear(_ animated: Bool) {
    ProfileModel.synchronize()
    nameTextField.text = ProfileModel.name
    emailTextField.text = ProfileModel.email
    professionTextField.text = ProfileModel.profession
  }

  @IBAction func saveAccount(_ sender: Any) {
    if let name = nameTextField.text, let email = emailTextField.text, let profession = professionTextField.text {
      if name.isEmpty {
        textEmpty("Name")
      } else if email.isEmpty {
        textEmpty("Email")
      } else if profession.isEmpty {
        textEmpty("Profession")
      } else {
        saveProfil(name, email, profession)

        self.dismiss(animated: true)
      }
    }
  }
  @IBAction func cancelUpdate(_ sender: Any) {
    self.dismiss(animated: true)
  }

  func saveProfil(_ name: String, _ email: String, _ profession: String) {
    ProfileModel.stateLogin = true
    ProfileModel.name = name
    ProfileModel.email = email
    ProfileModel.profession = profession
  }

  func textEmpty(_ field: String) {
    let alert = UIAlertController(
      title: "Alert",
      message: "\(field) is empty",
      preferredStyle: UIAlertController.Style.alert
    )
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}
