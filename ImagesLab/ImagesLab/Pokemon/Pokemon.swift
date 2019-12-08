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
    let imageUrlHiRes: String
    let imageUrl: String
    let types: [String]
    let set: String
    let weaknesses: [Weaknesses]
}
struct Weaknesses: Decodable {
    let type: String
    let value: String
}

