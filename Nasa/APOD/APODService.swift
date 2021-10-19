//
//  APODService.swift
//  Nasa
//
//  Created by Gladkov Maxim on 16.10.2021.
//

import UIKit

class APODService {
    var APODResponse: APODModel?
    
    static func getAPOD(completion: @escaping (_ APODResponse: APODModel, _ imageData: Data) -> ()) {
        print("getAPOD")

        guard let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=YhOi1mhKm17uKLbaUbxo5EmtjOcSIiAC0LQvBcTE") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else { return }
            
            if let apodResponse = try? JSONDecoder().decode(APODModel.self, from: data),
               let imgURLString = apodResponse.hdurl,
               let imgURL = URL(string: imgURLString),
               let imageData = try? Data(contentsOf: imgURL) {
                
                DispatchQueue.main.async {
                    completion(apodResponse, imageData)
                    print("complition")
                }
            }
        }.resume()
    }
}
