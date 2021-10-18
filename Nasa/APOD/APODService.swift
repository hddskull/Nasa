//
//  APODService.swift
//  Nasa
//
//  Created by Gladkov Maxim on 16.10.2021.
//

import Foundation

class APODService {
    var APODResponse: APODModel?
    var imageData: Data?
    
    func getAPOD() {
        let urlString = ""
        guard let url = URL(string: urlString) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            if error != nil {
                print("error apod request \(error)")
            }
            guard let data = data else { return }
            let apodResponse = try? JSONDecoder().decode(APODModel.self, from: data)
            self.APODResponse = apodResponse
        }.resume()
    }
    
    func getAPODImageData() {
        DispatchQueue.global(qos: .userInitiated).async{
            guard
                let apod = self.APODResponse,
                let url = apod.url,
                let imageUrl = URL(string: url),
                let data = try? Data(contentsOf: imageUrl)
            else { return }
            self.imageData = data
        }

    }
}
