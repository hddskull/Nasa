//
//  MarsNetworkManager.swift
//  Nasa
//
//  Created by Max Gladkov on 20.10.2021.
//

import Foundation

class EarthNetworkManager {

    static func getEarthImageNames(_ currentDate: String, completion: @escaping (_ imageNames: [String]) -> ()) {
        
        print("currentDate in getEarthImageNames: ", currentDate)
        var imageNames = [String]()
        let urlString = "https://api.nasa.gov/EPIC/api/natural/date/\(currentDate)?api_key=YhOi1mhKm17uKLbaUbxo5EmtjOcSIiAC0LQvBcTE"
        
        guard let url = URL(string: urlString) else { return }
        print("url formed")
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            if let epicModel = try? JSONDecoder().decode([MarsModel].self, from: data){
                for item in epicModel {
                    imageNames.append(item.image)
                }
            }
            
            DispatchQueue.main.async {
                completion(imageNames)
            }
        }.resume()
    }
    
    static func getEarthImages(_ imageNames: [String], completion: @escaping(_ imageArr: [Data]) -> ()) {
        
        let queue = DispatchQueue.global(qos: .utility)
        
        queue.async {
            var imageArr = [Data]()
            
            for name in imageNames {
                let urlImagesString = "https://api.nasa.gov/EPIC/archive/natural/2020/10/11/png/\(name).png?api_key=YhOi1mhKm17uKLbaUbxo5EmtjOcSIiAC0LQvBcTE"
                
                guard let imgURL = URL(string: urlImagesString),
                      let imageData = try? Data(contentsOf: imgURL)
                else { return }
                
                imageArr.append(imageData)
            }
            
            DispatchQueue.main.async {
                completion(imageArr)
            }
        }
    }
}
