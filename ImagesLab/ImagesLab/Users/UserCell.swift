//
//  UserCell.swift
//  ImagesLab
//
//  Created by casandra grullon on 12/10/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var cellphoneLabel: UILabel!
    
    var user: User?
    
    func configureUserCell(for user: User){
        nameLabel.text = "\(user.name.first) \(user.name.last)"
        ageLabel.text = user.dob.age.description
        cellphoneLabel.text = user.cell
        
        NetworkHelper.shared.performDataTask(with: user.picture.thumbnail) { (result) in
            switch result{
            case .failure(let appError):
                print("in cell appError: \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.profilePicture.image = UIImage(data: image)
                }
            }
        }
    }
    
    

}
