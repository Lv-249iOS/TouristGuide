//
//  ImageCacheLoader.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/2/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

class ImageDownloader {
    static var shared = ImageDownloader()
    let imageStorage = ImageStore()
    var imageNames: [String] = []
    
    func obtainImage(with imgRef: String, completion: @escaping ((UIImage)->())) {
        if let image = try? imageStorage.getImage(by: imgRef), let img = image {
            print("GOT from file system")
            isNeedClear()
            DispatchQueue.main.async { completion(img) }
        } else {
            DispatchQueue.main.async { completion(#imageLiteral(resourceName: "noImage")) }
            print("LOADING from net")
            guard let url = UrlFormatter().createUrlForImageDownloading(with: imgRef) else { return }
            DispatchQueue.global(qos: .utility).async {
                if let data = try? Data(contentsOf: url) {
                    guard let img = UIImage(data: data) else { return }
                    self.imageStorage.save(image: img, with: imgRef)
                    self.imageNames.append(imgRef)
                    self.isNeedClear()
                    DispatchQueue.main.async { completion(img) }
                }
            }
        }
    }
    
    func isNeedClear() {
        if imageNames.count > 20 {
            imageStorage.clearAllFilesFromDirectory()
            imageNames = []
            print("CLEARED")
        }
    }
}



