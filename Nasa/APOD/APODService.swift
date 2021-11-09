//
//  APODService.swift
//  Nasa
//
//  Created by Gladkov Maxim on 16.10.2021.
//

import UIKit

class APODService {
    var APODResponse: APODModel?
    
    static func getAPOD(completion: @escaping (_ APODResponse: APODModel) -> ()) {

        guard let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=YhOi1mhKm17uKLbaUbxo5EmtjOcSIiAC0LQvBcTE") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            
            guard let data = data,
                  let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200
            else {
                print("http response error")
                return
            }
            
            guard let apodResponse = try? JSONDecoder().decode(APODModel.self, from: data)
            else { print("APOD Model mapping error")
                return
            }
            
            DispatchQueue.global(qos: .utility).async {
                completion(apodResponse)
            }
        }.resume()
    }
    
    static func getAPODImage(imgUrl: String, completion: @escaping (_ imageData: Data) -> ()){
        
        guard let url = URL(string: imgUrl),
              let imageData = try? Data(contentsOf: url)
        else {
            print("no APOD image from URL")
            return
        }
        
         DispatchQueue.main.async {
             completion(imageData)
         }
     }
}
