//
//  BreedsListResponse.swift
//  RandDog
//
//  Created by Mahmoud on 6/1/19.
//  Copyright © 2019 Mahmoud. All rights reserved.
//

import Foundation
struct BreedsListResponse:Codable {
    let status: String
    let message: [String:[String]]
}
