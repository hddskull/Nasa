//
//  ImageManager.swift
//  Nasa
//
//  Created by Max Gladkov on 21.10.2021.
//

import Foundation
import UIKit

class ImageManager {
    static func saveImage(imageNames: [String], imageDataArr: [Data], completion: @escaping (_ smt: String) -> ()){
        
        let queue = DispatchQueue.global(qos: .utility)
        
        queue.async {
            for i in 0..<imageNames.count {
                
                guard let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
                
                let fileUrl = docDir.appendingPathComponent(imageNames[i])
                
                let data = imageDataArr[i]
                
                if !FileManager.default.fileExists(atPath: fileUrl.path) {
                    do {
                        try data.write(to: fileUrl)
                    } catch {
                        print("error savin image \(imageNames[i])")
                    }
                } else {
                    print("\(imageNames[i]) already exists")
                }
            }
            
            DispatchQueue.main.sync {
                completion("smt")
            }
        }
        
    }
    
    static func loadImage(imageNames: [String], completion: @escaping (_ images: [UIImage]) -> ()) {
        
        let queue = DispatchQueue.global(qos: .utility)
        
        queue.async( flags: .barrier) {
            var images = [UIImage]()
            for imageName in imageNames {
                let docDir = FileManager.SearchPathDirectory.documentDirectory
                
                let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
                let paths = NSSearchPathForDirectoriesInDomains(docDir, userDomainMask, true)
                if let dirPath = paths.first {
                    if let imageURL = try? URL(fileURLWithPath: dirPath).appendingPathComponent(imageName), let image = UIImage(contentsOfFile: imageURL.path) {
                        images.append(image)
                    } else {
                        print("no images in local")
                    }
                }
            }
            DispatchQueue.main.sync {
                completion(images)
            }
        }
    }
}
