//
//  ComicAPI.swift
//  ImagesLab
//
//  Created by casandra grullon on 12/7/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import Foundation

struct Comic: Decodable {
    let month: String
    var num: Int
    let year: String
    let img: String
    let title: String
    let day: String
}


