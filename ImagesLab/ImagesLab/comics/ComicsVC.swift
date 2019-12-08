//
//  ViewController.swift
//  ImagesLab
//
//  Created by casandra grullon on 12/6/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import UIKit

class ComicsVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textFieldOutfield: UITextField!
    @IBOutlet weak var stepper: UIStepper!
    
    var comics = [Comic]()
    
    var comicDay: Double = 1.0 {
        didSet{
            print("value: \(stepper.value)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadComics()
        configureStepper()
    }
    
    func configureStepper(){
        let stringNumber: String = comics.first?.day ?? ""
        let numberAsNumber = Double(stringNumber)
        stepper.minimumValue = 1.0
        stepper.maximumValue = 30.0
        stepper.stepValue = 1.0
        stepper.value = numberAsNumber ?? 1.0
    }
    
    func loadComics(){
        ComicAPIClient.getComic { (result) in
            switch result {
            case .failure(let appError):
                print("appError: \(appError)")
            case .success(let comics):
                print("comics count: \(comics)")
            }
        }
    }
    
    @IBAction func stepperClicked(_ sender: UIStepper) {
        comicDay = sender.value
        NetworkHelper.shared.performDataTask(with: comics.first?.img ?? "") { (result) in
            switch result{
            case .failure(let appError):
               print("appError: \(appError)")
            case .success(let data):
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
    
    @IBAction func mostRecentButtonClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func randomButtonPressed(_ sender: UIButton) {
        
    }
    
}

