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
    
    var cache = Cacher()
    var loader = Loader()
    
    func getData(with keys: [String], completion: @escaping ([RegionId: [Place]?]?)->()) {
        var cachedPlaces: [RegionId: [Place]] = [:]
        var loadedPlaces: [RegionId: [Place]] = [:]
        
        for key in keys {
            if let data = cache.getFromCache(with: key) {
                print("CACHE")
                let converter = DataConverter()
                var places: [Place] = []
                
                for dat in data {
                    if let place = converter.convert(data: dat) {
                        places.append(place)
                    }
                }
                
                cachedPlaces[key] = places
                
                if key == keys.last {
                    completion(cachedPlaces)
                }
                
            } else {
                var places: [Place] = []
                loader.loadData(with: key) { [weak self] data, err in
                    print(" LOAD ")
                    guard let data = data else { return }
                    for dat in data {
                        guard let place = JsonPlacesParser().parsePlace(with: dat) else { return }
                        places.append(place)
                    }
                    
                    self?.cache.save(places: places, key: key)
                    
                    loadedPlaces[key] = places
                    
                    if key == keys.last {
                        completion(loadedPlaces)
                    }
                }
            }
        }
    }
}
