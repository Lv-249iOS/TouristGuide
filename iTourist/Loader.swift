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
        print("Start load places id in Loader.loadData")
        guard let req = RequestFormatter().createIdUrlRequest(with: key) else {
            let err = NSError(domain: "Bad url request", code: 0, userInfo: nil)
            completion(nil, err)
            return
        }
        
        load(with: req) { [weak self] data in
            print("Loaded places id")
            guard let data = data, let placeIds = JsonPlacesParser().parseIds(with: data) else { return }
            var dataBuffer: [Data] = []
            
            for id in placeIds {
                guard let placeReq = RequestFormatter().createPlaceRequest(with: id) else { return }
                self?.load(with: placeReq) { data in
                    
                    guard let dat = data else { return }
                    dataBuffer.append(dat)
                    
                    if id == placeIds.last {
                        print("Loaded place" + "\(placeIds.count)")
                        completion(dataBuffer, nil)
                    }
                }
            }
        }
    }
    
    func load(with request: URLRequest, completion: @escaping (Data?)->()) {
        URLSession.shared.dataTask(with: request) { data, response, err in
            completion(data)
        }.resume()
    }
}
