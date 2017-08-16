//
//  ImageCacheLoader.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/2/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

class ImageManager {
    
    static var shared = ImageManager()
    
    let loader = Loader()
    let formatter = RequestFormatter()
    let imageStorage = ImageStore()
    
    /// Gets image from image storage and immediately return image in callback.
    /// If it is impossible - returns default image in callback and then async loads from net,
    /// saves in image storage and when loading was ended return image in callback
    func obtainImage(with imgRef: String, completion: @escaping ((UIImage)->())) {
        if let image = try? imageStorage.getImage(by: imgRef), let img = image {
            print("GOT from file system")
            checkIfStorageNeedsToBeCleaned()
            DispatchQueue.main.async { completion(img) }
        } else {
            DispatchQueue.main.async { completion(#imageLiteral(resourceName: "noImage")) }
            print("LOADING from net")
            guard let req = formatter.createImageRequest(with: imgRef) else { return }
            loader.load(with: req) { data in
                guard let data = data, let img = UIImage(data: data) else { return }
                self.imageStorage.save(image: img, with: imgRef)
                self.checkIfStorageNeedsToBeCleaned()
                DispatchQueue.main.async { completion(img) }
            }
        }
    }
    
    /// Checks if storage needs to be cleaned
    func checkIfStorageNeedsToBeCleaned() {
        if let storageCapacity = imageStorage.countImagesInDirectory, storageCapacity > imageStorage.storageLimit {
            imageStorage.clearAllFilesFromDirectory()
            print("CLEARED")
        }
    }
}



