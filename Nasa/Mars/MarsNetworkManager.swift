//
//  MarsNetworkManager.swift
//  Nasa
//
//  Created by Max Gladkov on 25.11.2021.
//

import Foundation
import UIKit
class MarsNetworkManager {
    static func getMarsPhotoData(forRover: RoverName, camera: RoverCamera, date: String, completion: @escaping (_ marsModelPhotos: MarsModelPhotos)->() ) {
        let apiKey = "YhOi1mhKm17uKLbaUbxo5EmtjOcSIiAC0LQvBcTE"
        let urlString = "https://api.nasa.gov/mars-photos/api/v1/rovers/\(forRover.rawValue)/photos?earth_date=\(date)&api_key=\(apiKey)&camera\(camera.rawValue)"
        print(urlString)
        guard let url = URL(string: urlString)
        else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let marsModelPhotos = try? JSONDecoder().decode(MarsModelPhotos.self, from: data)
            else { return }
            
            completion(marsModelPhotos)
        }.resume()
    }
    
    static func getMarsImage(urlString: String, completion: @escaping (_ imageData: Data) -> ()) {
        
        DispatchQueue.global(qos: .utility).sync {
            guard let url = URL(string: urlString),
                  let imageData = try? Data(contentsOf: url)
            else {
                return
            }
            completion(imageData)
        }
       
    }
}
