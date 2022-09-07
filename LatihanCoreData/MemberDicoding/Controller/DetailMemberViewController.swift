//
//  DetailMemberViewController.swift
//  MemberDicoding
//
//  Created by Gilang Ramadhan on 24/06/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import UIKit

class DetailMemberViewController: UIViewController {
  var memberId: Int = 0

  private lazy var memberProvider: MemberProvider = { return MemberProvider() }()

  @IBOutlet weak var imageMember: UIImageView!
  @IBOutlet weak var fullNameMember: UILabel!
  @IBOutlet weak var professionMember: UILabel!
  @IBOutlet weak var emailMember: UILabel!
  @IBOutlet weak var aboutMember: UILabel!

  @IBAction func deleteMember(_ sender: UIButton) {
    let alert = UIAlertController(title: "Warning", message: "Do you want to delete this member?", preferredStyle: .alert)

    alert.addAction(UIAlertAction(title: "Yes", style: .default) { _ in
      self.deleteMember()
    })

    alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

    self.present(alert, animated: true, completion: nil)
  }

  @IBAction func editMember(_ sender: UIButton) {
    let alert = UIAlertController(title: "Warning", message: "Do you want to change this member?", preferredStyle: .alert)

    alert.addAction(UIAlertAction(title: "Yes", style: .default) { _ in
      self.performSegue(withIdentifier: "moveToEdit", sender: self)
    })

    alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

    self.present(alert, animated: true, completion: nil)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    loadMembers()
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "moveToEdit" {
      if let vc = segue.destination as? FormMemberViewController {
        vc.memberId = self.memberId
      }
    }
  }

  private func loadMembers() {
    memberProvider.getMember(memberId) { member in
      DispatchQueue.main.async {
        self.fullNameMember.text = member.name
        self.professionMember.text = member.profession
        self.emailMember.text = member.email
        self.aboutMember.text = member.about
        if let image = member.image {
          self.imageMember.image = UIImage(data: image)
          self.imageMember.layer.cornerRadius = self.imageMember.frame.height / 2
          self.imageMember.clipsToBounds = true
        }
      }
    }
  }

  private func deleteMember() {
    memberProvider.deleteMember(memberId) {
      DispatchQueue.main.async {
        let alert = UIAlertController(title: "Successful", message: "Member deleted.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
          self.navigationController?.popViewController(animated: true)
        })
        self.present(alert, animated: true, completion: nil)
      }
    }
  }
}
