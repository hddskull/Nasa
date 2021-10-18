//
//  APODModel.swift
//  Nasa
//
//  Created by Gladkov Maxim on 16.10.2021.
//

import Foundation

struct APODModel: Decodable {
    var apodName: String?
    var apodDescription: String?
    var url: String?
}
