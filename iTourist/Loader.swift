//
//  Loader.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/9/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import CoreLocation

class Loader {
    
    func loadData(with key: String, completion: @escaping ([Data]?, Error?)->()) {
        print("Start load")
        guard let req = createIdUrlRequest(with: key) else {
            let err = NSError(domain: "Bad url request", code: 0, userInfo: nil)
            completion(nil, err)
            return
        }
        
        load(with: req) { data in
            guard let data = data else { return }
            guard let placeIds = JsonPlacesParser().parseIds(with: data) else { return }
            var dataBuffer: [Data] = []
            
            for id in placeIds {
                guard let placeReq = self.createPlaceRequest(with: id) else { return }
                self.load(with: placeReq) { data in
                    guard let dat = data else { return }
                    dataBuffer.append(dat)
                    
                    if id == placeIds.last {
                        print("END load")
                        completion(dataBuffer, nil)
                    }
                }
            }
        }
        
        print("Start load")
    }
    
    func createIdUrlRequest(with key: String) -> URLRequest? {
        guard let url = UrlFormatter().createUrlForPlacesIdsReq(with: key) else { return nil }
        return URLRequest(url: url)
    }
    
    func createPlaceRequest(with id: String) -> URLRequest? {
        guard let url = UrlFormatter().createUrlForPlaceDetailReq(with: id) else { return nil }
        return URLRequest(url: url)
    }
    
    func load(with request: URLRequest, completion: @escaping (Data?)->()) {
        URLSession.shared.dataTask(with: request) { data, response, err in
            completion(data)
        }.resume()
    }
}
