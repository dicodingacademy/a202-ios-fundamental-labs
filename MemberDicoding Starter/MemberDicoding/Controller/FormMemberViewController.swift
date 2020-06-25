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

    @IBOutlet weak var titleForm: UILabel!
    @IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var imageMember: UIImageView!
    @IBOutlet weak var nameMember: UITextField!
    @IBOutlet weak var emailMember: UITextField!
    @IBOutlet weak var professionMember: UITextField!
    @IBOutlet weak var aboutMember: UITextField!
    
    @IBAction func saveMember(_ sender: UIButton) {
        save()
    }
    
    @IBAction func getImage(_ sender: UIButton) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        imageMember.layer.cornerRadius = imageMember.frame.height / 2
        imageMember.clipsToBounds = true
    }
    
    private func save() {
        
    }
}

extension FormMemberViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let result = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            self.imageMember.contentMode = .scaleToFill
            self.imageMember.image = result
            dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Failed", message: "Image can't be loaded.", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}
