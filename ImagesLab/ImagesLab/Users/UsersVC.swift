//
//  UsersVC.swift
//  ImagesLab
//
//  Created by casandra grullon on 12/10/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import UIKit

class UsersVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var users = [User](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()

            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadData()

    }

    func loadData(){
        UserAPIClient.getUsers { (result) in
            switch result{
            case .failure(let appError):
                print("appError: \(appError)")
            case .success(let people):
                self.users = people
            }
        }
    }
    

}
extension UsersVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UserCell else {
            fatalError("cell issue")
        }
        let user = users[indexPath.row]
        
        cell.configureUserCell(for: user)
        return cell
    }
}
extension UsersVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
