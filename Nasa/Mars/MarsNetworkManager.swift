//
//  MarsNetworkManager.swift
//  Nasa
//
//  Created by Max Gladkov on 20.10.2021.
//

import Foundation

class MarsNetworkManager {
    
    static func getMarsImage(completion: @escaping (_ imageDataArray: [Data]) -> ()) {
        
        print("getMarsImage")
        var imageDataArray = [Data]()
//        let urlImagesString = "https://api.nasa.gov/EPIC/archive/natural/2020/10/10/png/epic_1b_20201010004554.png?api_key=YhOi1mhKm17uKLbaUbxo5EmtjOcSIiAC0LQvBcTE"
        
        guard let urlImgParam = URL(string: "https://api.nasa.gov/EPIC/api/natural/date/2020-10-10?api_key=YhOi1mhKm17uKLbaUbxo5EmtjOcSIiAC0LQvBcTE") else { return }
        
        let session = URLSession.shared
        session.dataTask(with: urlImgParam) { data, response, error in
            guard let data = data, let response = response else { return }
            
            if let epicResponse = try? JSONDecoder().decode([EPICDataModel].self, from: data) {
                for i in 0..<3 {
                    let imageParam = epicResponse[i].image
                    let urlImagesString = "https://api.nasa.gov/EPIC/archive/natural/2020/10/10/png/\(imageParam).png?api_key=YhOi1mhKm17uKLbaUbxo5EmtjOcSIiAC0LQvBcTE"
                    print(urlImagesString)
                    //use late imageParam and and func param "current data" in making url
                    guard let imgURL = URL(string: urlImagesString),
                          let imageData = try? Data(contentsOf: imgURL)
                    else { return }
                    
                    imageDataArray.append(imageData)
                    print("appended")
                   }
                    
                    DispatchQueue.main.async {
                        completion(imageDataArray)
                        print("getMarsImagecomplition")
                    }
            }
        }.resume()
    }
}
