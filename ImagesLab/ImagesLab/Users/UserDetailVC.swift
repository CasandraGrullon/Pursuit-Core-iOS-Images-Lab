//
//  UserDetailVC.swift
//  ImagesLab
//
//  Created by casandra grullon on 12/10/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import UIKit

class UserDetailVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }

    func updateUI(){
        guard let people = user else {
            return
        }
        namelabel.text = "\(people.name.first) \(people.name.last)"
        ageLabel.text = "\(people.dob.age) years old"
        cellLabel.text = "Cell number: \(people.cell)"
        phoneLabel.text = "Home number: \(people.phone)"
        locationLabel.text = "\(people.location.street.number) \(people.location.street.name)\n \(people.location.city), \(people.location.state)\n \(people.location.country), \(people.location.postcode.turnToString())"
        
        NetworkHelper.shared.performDataTask(with: people.picture.large) { [unowned self] (result) in
            switch result{
            case .failure(let appError):
                print("appError: \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: image)
                }
            }
        }
    }

}
