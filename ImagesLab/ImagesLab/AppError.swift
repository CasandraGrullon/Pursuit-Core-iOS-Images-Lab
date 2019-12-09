//
//  AppError.swift
//  ImagesLab
//
//  Created by casandra grullon on 12/7/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import Foundation

enum AppError: Error {
    case badURL(String)
    case noResponse
    case networkClientError(Error)
    case noData
    case badStatusCode(Int)
    case decodingError(Error)
    case missingValue
}
