//
//  ComicAPIClient.swift
//  ImagesLab
//
//  Created by casandra grullon on 12/7/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import Foundation

struct ComicAPIClient {
    static func getComic(completion: @escaping (Result<Comic, AppError>) ->()) {
        
        let endpointURLString = "https://xkcd.com/614/info.0.json"
        
        NetworkHelper.shared.performDataTask(with: endpointURLString) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do{
                    let comicSearch = try JSONDecoder().decode(Comic.self, from: data)
                    let comics = comicSearch
                    completion(.success(comics))
                }catch{
                    completion(.failure(.decodingError(error)))
                }
                
                
            }
        }
        
    }
}

