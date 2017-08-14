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
    
    func getData(with keys: [(key: String, loc: String)], completion: @escaping ([RegionId: [Place]?]?)->()) {
        var cachedPlaces: [RegionId: [Place]] = [:]
        var loadedPlaces: [RegionId: [Place]] = [:]
        
        for key in keys {
            if let data = cacher.getFromCache(with: key.key) {
                print("USE CACHED DATA")
                cachedPlaces[key.key] = data
                key == keys.last! ? completion(cachedPlaces) : (/* move on */)
                
            } else {
                var places: [Place] = []
                print("LOADING........")
                loader.loadData(with: key.loc) { [weak self] data, err in
                    guard let data = data else { return }
                    for dat in data {
                        guard let place = JsonPlacesParser().parsePlace(with: dat) else { return }
                        places.append(place)
                    }
                    
                    self?.cacher.save(places: places, key: key.key)
                    loadedPlaces[key.key] = places
                    
                    if key == keys.last! {
                        print("LOADED")
                        completion(loadedPlaces)
                    }
                }
            }
        }
    }
}
