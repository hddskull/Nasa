//
//  ImageManager.swift
//  Nasa
//
//  Created by Max Gladkov on 21.10.2021.
//

import Foundation
import UIKit

class ImageManager {
    static func saveImage(imageNames: [String], imageDataArr: [Data]){
        
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
            print("images saved")
        }
        
    }
    
    static func loadImage(imageNames: [String], completion: @escaping (_ images: [UIImage]) -> ()) {
        
        let queue = DispatchQueue.global(qos: .utility)
        
        queue.async( flags: .barrier) {
            print("in async")
            var images = [UIImage]()
            for imageName in imageNames {
                let docDir = FileManager.SearchPathDirectory.documentDirectory
                
                let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
                let paths = NSSearchPathForDirectoriesInDomains(docDir, userDomainMask, true)
                if let dirPath = paths.first {
                    
                    let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(imageName)
                    guard let image = UIImage(contentsOfFile: imageURL.path) else { return }
                    images.append(image)
                    print("image appended")
                }
            }
            print("before DispatchQueue main")
            DispatchQueue.main.sync {
                completion(images)
            }
        }
    }
}
