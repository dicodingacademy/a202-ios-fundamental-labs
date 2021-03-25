//
//  FormMemberViewController.swift
//  MemberDicoding
//
//  Created by Gilang Ramadhan on 24/06/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import UIKit

class FormMemberViewController: UIViewController {

    private let imagePicker = UIImagePickerController()
    private lazy var memberProvider: MemberProvider = { return MemberProvider() }()

    var memberId: Int = 0

    @IBOutlet weak var titleForm: UILabel!
    @IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var imageMember: UIImageView!
    @IBOutlet weak var nameMember: UITextField!
    @IBOutlet weak var emailMember: UITextField!
    @IBOutlet weak var professionMember: UITextField!
    @IBOutlet weak var aboutMember: UITextField!

    @IBAction func saveMember(_ sender: UIButton) {
        saveMember()
    }

    @IBAction func getImage(_ sender: UIButton) {
        self.present(imagePicker, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupForm()
    }

    private func loadMembers() {
        // load member
    }

    private func setupView() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary

        imageMember.layer.cornerRadius = imageMember.frame.height / 2
        imageMember.clipsToBounds = true
    }

    private func setupForm() {
        if memberId > 0 {
            titleForm.text = "Update Member"
            loadMembers()
        } else {
            titleForm.text = "Create New Member"
            titleButton.isEnabled = false
        }
    }

    private func saveMember() {
        guard let name = nameMember.text, name != "" else {
            alert("Field name is empty")
            return
        }

        guard let email = emailMember.text, email != "" else {
            alert("Field email is empty")
            return
        }

        guard let profession = professionMember.text, profession != "" else {
            alert("Field profession is empty")
            return
        }

        guard let about = aboutMember.text, about != "" else {
            alert("Field about is empty")
            return
        }

        if let image = imageMember.image, let data = image.pngData() as NSData? {
            // do save
        }
    }

    func alert(_ message: String) {
        let allertController = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        allertController.addAction(alertAction)
        self.present(allertController, animated: true, completion: nil)
    }
}

extension FormMemberViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        if let result = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.imageMember.contentMode = .scaleToFill
            self.imageMember.image = result
            titleButton.isEnabled = true
            dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Failed", message: "Image can't be loaded.", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
