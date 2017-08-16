//
//  DataProvider.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/9/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation

class DataProvider {
    
    static var shared = DataProvider()
    
    private var cacher = Cacher()
    private var loader = Loader()
    private var requestFormatter = RequestFormatter()
    private var parser = JsonPlacesParser()
    
    func getData(with keys: [(key: String, loc: String)], completion: @escaping ([RegionId: [Place]?]?)->()) {
        var cachedPlaces: [RegionId: [Place]] = [:]
        var loadedPlaces: [RegionId: [Place]] = [:]
        
        for key in keys {
            guard let data = cacher.getFromCache(with: key.key) else {
                print("LOADING........")
                guard let req = requestFormatter.createIdUrlRequest(with: key.loc) else { return }
                var places: [Place] = []
                
                loader.load(with: req) { [weak self] data in
                    guard let data = data, let placeIds = self?.parser.parseIds(with: data) else { return }
                    
                    for id in placeIds {
                        guard let placeReq = self?.requestFormatter.createPlaceRequest(with: id) else { return }
                        self?.loader.load(with: placeReq) { data in
                            guard let dat = data, let place = self?.parser.parsePlace(with: dat) else { return }
                            places.append(place)
                            
                            if id == placeIds.last {
                                self?.cacher.save(places: places, key: key.key)
                                loadedPlaces[key.key] = places
                                key == keys.last! ? completion(loadedPlaces) : (/* move on */)
                            }
                        }
                    }
                }
                
                return
            }
            
            print("USED CACHED DATA")
            cachedPlaces[key.key] = data
            key == keys.last! ? completion(cachedPlaces) : (/* move on */)
        }
    }
}
