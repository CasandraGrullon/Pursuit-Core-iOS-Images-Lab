//
//  Pokemon.swift
//  ImagesLab
//
//  Created by casandra grullon on 12/8/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
    let cards: [Cards]
}
struct Cards: Decodable {
    let name: String
    let type: [String]
    let imageHiRes: String
    let imageURL: String
    let set: String
    let weakness: [Weakness]
}
struct Weakness: Decodable {
    let type: String
    let value: String
}
