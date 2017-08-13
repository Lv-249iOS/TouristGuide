//
//  ImageCacheLoader.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/2/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation
import UIKit

class ImageDownloader {
    static var shared = ImageDownloader()
    
    var urlSession: URLSession
    var cache: NSCache<NSString, UIImage>
    
    init() {
        urlSession = URLSession.shared
        cache = NSCache()
        cache.countLimit = 20
    }
    
    func obtainImage(with path: String, completion: @escaping ((UIImage)->())) {
        if let image = cache.object(forKey: path as NSString) {
            DispatchQueue.main.async { completion(image) }
        } else {
            DispatchQueue.main.async { completion(#imageLiteral(resourceName: "noImage")) }

            guard let url = URL(string: path) else { return }
            DispatchQueue.global(qos: .utility).async {
                if let data = try? Data(contentsOf: url) {
                    guard let img = UIImage(data: data) else { return }
                    self.cache.setObject(img, forKey: path as NSString)
                    
                    DispatchQueue.main.async { completion(img) }
                }
            }
        }
    }
    
    // I need this method to handle errors and show activity indicator
    func downloadImage(with path: String, completion: @escaping ((UIImage)->())) {
        if let image = cache.object(forKey: path as NSString) {
            completion(image)
        } else {
            guard let url = URL(string: path) else {
                completion(#imageLiteral(resourceName: "noImage"))
                return
            }
            
            urlSession.dataTask(with: url, completionHandler: { (data, response, error) in
                guard error == nil else {
                    completion(#imageLiteral(resourceName: "noImage"))
                    return
                }
                guard let data = data else {
                    completion(#imageLiteral(resourceName: "noImage"))
                    return
                }
                
                guard let image = UIImage(data: data) else {
                    completion(#imageLiteral(resourceName: "noImage"))
                    return
                }
                
                completion(image)
            }).resume()
        }
    }
}
