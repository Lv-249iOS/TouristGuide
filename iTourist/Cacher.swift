//
//  Cacher.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/9/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation

class Cacher {
    
    var cacher = URLCache.shared
    
    init() {
        let oneMB = 1024 * 1024
        let cache = URLCache(memoryCapacity: 100 * oneMB, diskCapacity: 200 * oneMB, diskPath: "urlCache")
        cacher = cache
    }
    
    func save(data: Data, key: String) {
        // save data in cache

       // self.cacher.storeCachedResponse(chacedResponse, for: key)


    }
    
    func getFromCache(with key: String) -> [Data]? {
        /*guard let url = UrlFormatter().createUrlForPlacesIdsReq(with: key) else { return nil }
        let request = URLRequest(url: url)
        
        if let response = cacher.cachedResponse(for: request) {
            response.data
        }*/
        
        return nil
    }

}
