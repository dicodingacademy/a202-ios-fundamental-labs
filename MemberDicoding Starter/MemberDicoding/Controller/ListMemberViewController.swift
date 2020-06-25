//
//  ViewController.swift
//  MemberDicoding
//
//  Created by Gilang Ramadhan on 24/06/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import UIKit

class ListMemberViewController: UIViewController {
    
    @IBOutlet weak var memberTableView: UITableView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView(){
        memberTableView.delegate = self
        memberTableView.dataSource = self
    }
}

extension ListMemberViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "member", for: indexPath) as? MemberTableViewCell {
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension ListMemberViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "moveToDetail", sender: self)
    }
}
