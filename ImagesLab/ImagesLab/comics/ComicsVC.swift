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
    @IBOutlet weak var myText: UITextField!
    @IBOutlet weak var stepper: UIStepper!
    
    var comics = [Comic]()
    
    var comicDay: Double = 600 {
        didSet{
            print("value: \(stepper.value)")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStepper()
        loadDataforComic(comicDay: Int(stepper.value))
        myText.delegate = self
    }
    
    func loadDataforComic(comicDay:Int){
        ComicAPIClient.getComic(for: comicDay) { (result) in
            switch result{
            case .failure(let appError):
                print("appError: \(appError)")
            case .success(let comic):
                DispatchQueue.main.async {
                    self.myText.text = comic.num.description
                    self.loadDataforImage(comicImage: comic.img)
                    self.stepper.value = Double(comic.num)
                }
            }
        }
    }
    func loadDataforImage(comicImage: String){
        NetworkHelper.shared.performDataTask(with: comicImage) { (result) in
            switch result{
            case .failure(let appError):
                print(appError)
            case .success(let data):
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
    
    
    func configureStepper(){
        stepper.minimumValue = Double(comics.first?.num ?? 600)
        stepper.maximumValue = Double(comics.last?.num ?? 614)
        stepper.stepValue = 1.0
        stepper.value = Double(comics.first?.num ?? 600)
    }
    
    @IBAction func stepperClicked(_ sender: UIStepper) {
        loadDataforComic(comicDay: Int(sender.value))
    }
        
    @IBAction func mostRecentButtonClicked(_ sender: UIButton) {
        loadDataforComic(comicDay: Int(stepper.maximumValue))
    }
    
    @IBAction func randomButtonPressed(_ sender: UIButton) {
        var arrayOfNum = [Int]()
        for comic in comics {
            arrayOfNum.append(comic.num)
        }
        
        let randomComic = Double.random(in: stepper.minimumValue...stepper.maximumValue)
        
        loadDataforComic(comicDay: Int(randomComic))
    }
    
}

extension ComicsVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let stringInt = Int(myText.text!)
        loadDataforComic(comicDay: stringInt!)
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.text = ""
        return true
    }

}
