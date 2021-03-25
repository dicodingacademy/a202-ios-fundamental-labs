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
        // load member
    }

    private func deleteMember() {
        // delete member
    }

}
