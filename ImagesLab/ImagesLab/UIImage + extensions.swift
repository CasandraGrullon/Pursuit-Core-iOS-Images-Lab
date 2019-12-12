//
//  UIImage + extensions.swift
//  ImagesLab
//
//  Created by casandra grullon on 12/12/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import UIKit
extension UIImageView {
  func getImage(with urlString: String,
                completion: @escaping (Result<UIImage, AppError>) -> ()) {
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.color = .orange
    activityIndicator.startAnimating()
    activityIndicator.center = center
    addSubview(activityIndicator)
    
    NetworkHelper.shared.performDataTask(with: urlString) { [weak activityIndicator] (result) in
      DispatchQueue.main.async {
        activityIndicator?.stopAnimating() 
      }
      switch result {
      case .failure(let appError):
        completion(.failure(.networkClientError(appError)))
      case .success(let data):
        if let image = UIImage(data: data) {
          completion(.success(image))
        }
      }
    }
  }
}
