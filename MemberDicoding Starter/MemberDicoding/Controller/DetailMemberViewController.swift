//
//  DetailMemberViewController.swift
//  MemberDicoding
//
//  Created by Gilang Ramadhan on 24/06/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import UIKit

class DetailMemberViewController: UIViewController {
    
    @IBOutlet weak var imageMember: UIImageView!
    @IBOutlet weak var fullNameMember: UILabel!
    @IBOutlet weak var professionMember: UILabel!
    @IBOutlet weak var emailMember: UILabel!
    @IBOutlet weak var aboutMember: UILabel!
    
    @IBAction func deleteMember(_ sender: UIButton) {
        let alert = UIAlertController(title: "Warning", message: "Do you want to delete this member?", preferredStyle: .actionSheet)
       
        alert.addAction(UIAlertAction(title: "Yes", style: .default) { (action) in
            self.delete()
        })
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func editMember(_ sender: UIButton) {
        let alert = UIAlertController(title: "Warning", message: "Do you want to change this member?", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default) { (action) in
            self.performSegue(withIdentifier: "moveToEdit", sender: self)
        })
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView(){
        
    }
    
    private func delete() {
        
    }
}
