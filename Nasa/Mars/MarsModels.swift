//
//  MarsModels.swift
//  Nasa
//
//  Created by Max Gladkov on 25.11.2021.
//

import Foundation
import CoreText

enum RoverName: String {
    case Curiosity = "curiosity"
    case Opportunity = "opportunity"
    case Spirit = "spirit"
}
enum RoverCamera: String {
    case FHAZ = "=fhaz"
    case RHAZ = "=rhaz"
    case MAST = "=mast"
    case CHEMCAM = "=chemcam"
    case MAHLI = "=mahli"
    case MARDI = "=mardi"
    case NAVCAM = "=navcam"
    case PANCAM = "=pancam"
    case MINITES = "=minites"
    case all = ""
}

//MARK: Models for photo requset
class MarsModelPhotos: Decodable {
    var photos: [MarsModelPhoto]
}

class MarsModelPhoto: Decodable {
    var id: Int
    var sol: Int
    var camera : MarsCamera
    var img_src: String
    var earth_date: String
    var rover: MarsRover
}

class MarsCamera: Decodable {
    var id: Int
    var name: String
    var rover_id: Int
    var full_name: String
}

class MarsRover: Decodable {
    var id: Int
    var name: String
    var landing_date: String
    var launch_date: String
    var status: String
}
