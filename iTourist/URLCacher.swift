//
//  URLCacher.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/4/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation

class URLCacher {
    static var shared = URLCacher()
    var cacher = URLCache.shared
    
    init() {
        let oneMB = 1024 * 1024
        let cache = URLCache(memoryCapacity: 100 * oneMB, diskCapacity: 200 * oneMB, diskPath: "urlCache")
        cacher = cache
    }
    
    func getDataResponse(with request: URLRequest, completion: @escaping (Data?, Error?)->()) {
        if let response = cacher.cachedResponse(for: request) {
            completion(response.data, nil)
            
        } else {
            URLSession.shared.dataTask(with: request) { data, response, err in
                if let data = data, let response = response {
                    let chacedResponse = CachedURLResponse(response: response, data: data)
                    self.cacher.storeCachedResponse(chacedResponse, for: request)
                    completion(data, nil)
                    
                } else {
                    completion(nil, err)
                }
            }.resume()
        }
        
    }
    
    func updateDataREsponses() {
        
    }
    
    func releaseAllDataResponse() {
        cacher.removeAllCachedResponses()
    }
}
