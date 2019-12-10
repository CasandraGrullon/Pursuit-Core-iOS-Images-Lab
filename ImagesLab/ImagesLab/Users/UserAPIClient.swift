//
//  UserAPIClient.swift
//  ImagesLab
//
//  Created by casandra grullon on 12/10/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import Foundation

struct UserAPIClient {
    static func getUsers(completion: @escaping (Result<[User], AppError>) -> ()){
        
        let endpointURLString = "https://randomuser.me/api/?results=50"
        NetworkHelper.shared.performDataTask(with: endpointURLString) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let userData = try JSONDecoder().decode(Users.self, from: data)
                    let users = userData.results
                    completion(.success(users))
                }catch{
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
}
