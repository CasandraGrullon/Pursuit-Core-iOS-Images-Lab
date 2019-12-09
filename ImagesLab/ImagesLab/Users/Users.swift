//
//  Users.swift
//  ImagesLab
//
//  Created by casandra grullon on 12/9/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import Foundation

struct Users: Decodable {
    let results: [User]
}

struct User: Decodable {
    let name: String
    let location: String
    let phone: String
    let cell: String
}

struct Name: Decodable {
    let first: String
    let last: String
}

struct Location: Decodable {
    let street: [Street]
    let city: String
    let state: String
    let country: String
    let postcode: Postcode
    
}

struct Street: Decodable {
    let number: Int
    let name : String
}

enum Postcode: Decodable {
    case int(Int)
    case string(String)
    
    init(from decoder: Decoder) throws {
        if let intValue = try?
            decoder.singleValueContainer().decode(Int.self) {
            self = .int(intValue)
            return
        }
        if let stringValue = try?
            decoder.singleValueContainer().decode(String.self) {
            self = .string(stringValue)
            return
        }
        throw AppError.missingValue
    }
}
