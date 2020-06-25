//
//  DetailMemberViewController.swift
//  MemberDicoding
//
//  Created by Gilang Ramadhan on 24/06/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import UIKit
import CoreData

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
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default) { (action) in
            self.delete()
        })
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func editMember(_ sender: UIButton) {
        let alert = UIAlertController(title: "Warning", message: "Do you want to change this member?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default) { (action) in
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
        if (segue.identifier == "moveToEdit") {
            if let vc = segue.destination as? FormMemberViewController {
                vc.memberId = self.memberId
            }
        }
    }
    
    private func loadMembers(){
        memberProvider.getMember(memberId){ (result) in
            DispatchQueue.main.async {
                self.fullNameMember.text = result.value(forKeyPath: "name") as? String
                self.professionMember.text = result.value(forKeyPath: "profession") as? String
                self.emailMember.text = result.value(forKeyPath: "email") as? String
                self.aboutMember.text = result.value(forKeyPath: "about") as? String
                
                if let image = result.value(forKeyPath: "image") as? Data{
                    self.imageMember.image = UIImage(data: image)
                    self.imageMember.layer.cornerRadius = self.imageMember.frame.height / 2
                    self.imageMember.clipsToBounds = true
                }
            }
        }
    }
    
    private func delete() {
        memberProvider.deleteMember(memberId) {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Successful", message: "Member deleted.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default) { (action) in
                    self.navigationController?.popViewController(animated: true)
                })
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
