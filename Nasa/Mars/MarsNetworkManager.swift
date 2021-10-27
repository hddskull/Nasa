//
//  MarsNetworkManager.swift
//  Nasa
//
//  Created by Max Gladkov on 20.10.2021.
//

import Foundation

class MarsNetworkManager {
    
//    static func getMarsImage(completion: @escaping ((_ imageDataArray: [Data], _ imageNames: [String]) -> ())) {
//
//        print("getMarsImage")
//        var imageDataArray = [Data]()
//        var imageNames = [String]()
////        let urlImagesString = "https://api.nasa.gov/EPIC/archive/natural/2020/10/10/png/epic_1b_20201010004554.png?api_key=YhOi1mhKm17uKLbaUbxo5EmtjOcSIiAC0LQvBcTE"
//
//        guard let urlImgParam = URL(string: "https://api.nasa.gov/EPIC/api/natural/date/2020-10-10?api_key=YhOi1mhKm17uKLbaUbxo5EmtjOcSIiAC0LQvBcTE") else { return }
//
//        let session = URLSession.shared
//        session.dataTask(with: urlImgParam) { data, response, error in
//            guard let data = data, let _ = response else { return }
//
//            if let epicResponse = try? JSONDecoder().decode([EPICDataModel].self, from: data) {
//                for i in 0..<epicResponse.count {
//                    let imageParam = epicResponse[i].image
//                    imageNames.append(imageParam)
//                    let urlImagesString = "https://api.nasa.gov/EPIC/archive/natural/2020/10/10/png/\(imageParam).png?api_key=YhOi1mhKm17uKLbaUbxo5EmtjOcSIiAC0LQvBcTE"
//                    //use late imageParam and and func param "current data" in making url
//                    guard let imgURL = URL(string: urlImagesString),
//                          let imageData = try? Data(contentsOf: imgURL)
//                    else { return }
//
//                    imageDataArray.append(imageData)
//
//                   }
//                print("appended")
//
//                    DispatchQueue.main.async {
//                        completion(imageDataArray, imageNames)
//                    }
//            }
//        }.resume()
//    }
    
    
    static func getMarsImageNames(completion: @escaping (_ imageNames: [String]) -> ()) {
        
        
        var imageNames = [String]()
        let urlString = "https://api.nasa.gov/EPIC/api/natural/date/2020-10-11?api_key=YhOi1mhKm17uKLbaUbxo5EmtjOcSIiAC0LQvBcTE"
        
        guard let url = URL(string: urlString) else { return }
        print("url formed")
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            if let epicModel = try? JSONDecoder().decode([EPICDataModel].self, from: data){
                for item in epicModel {
                    imageNames.append(item.image)
                }
            }
            
            DispatchQueue.main.async {
                completion(imageNames)
            }
        }.resume()
    }
    
    static func getMarsImages(_ imageNames: [String], completion: @escaping(_ imageArr: [Data]) -> ()) {
        
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
