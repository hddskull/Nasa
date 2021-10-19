//
//  APODModel.swift
//  Nasa
//
//  Created by Gladkov Maxim on 16.10.2021.
//

import Foundation

struct APODModel: Decodable {
    var date: String?
    var explanation: String?
    var hdurl: String?
    var media_type: String?
    var service_version: String?
    var title: String?
    var url: String?
}
