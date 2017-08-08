//
//  ImageCacheLoader.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/2/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation
import UIKit

class ImageCacheLoader {
    
    var task: URLSessionDownloadTask
    var session: URLSession
    var cache: NSCache<NSString, UIImage>
    
    init() {
        session = URLSession.shared
        task = URLSessionDownloadTask()
        cache = NSCache()
        cache.countLimit = 10
    }
    
    func obtainImageWithPath(imagePath: String, completion: @escaping ((UIImage)->())) {
        if let image = cache.object(forKey: imagePath as NSString) {
            DispatchQueue.main.async {
                completion(image)
            }
        } else {
            DispatchQueue.main.async {
                completion(#imageLiteral(resourceName: "noImage"))
            }
            
            guard let url = URL(string: imagePath) else { return }
            task = session.downloadTask(with: url) { location, response, error in
                if let data = try? Data(contentsOf: url) {
                    guard var img = UIImage(data: data) else { return }
                    
                    img = img.resizeImage(sizeChange: CGSize(width: 200, height: 200))
                    self.cache.setObject(img, forKey: imagePath as NSString)
                    
                    DispatchQueue.main.async {
                        completion(img)
                    }
                }
            }
            task.resume()
        }
    }
}
