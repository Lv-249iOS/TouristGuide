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
    private var parser = JsonPlacesParser()
    private var requestFormatter = RequestFormatter()
    
    /// Processes all tuple getting data from cache and loading from Web, then returns results in 1 or 2 callbacks:
    /// first when got all the places from cache (if smth was in cache) and second when remainder of places
    /// was loaded (if smth had needed to be loaded)
    func getData(with keys: [(key: String, loc: String)], completion: @escaping ([RegionId: [Place]?]?)->()) {
        var cachedPlaces: [RegionId: [Place]] = [:]
        var loadedPlaces: [RegionId: [Place]] = [:]
        
        for key in keys {
            if let data = cacher.getFromCache(with: key.key) {
                print("USED CACHED DATA")
                cachedPlaces[key.key] = data
                key == keys.last! ? completion(cachedPlaces) : (/* move on */)
            } else {
                print("LOADING........")
                loadFromNet(with: key.loc) { [weak self] places in
                    guard let places = places else { return }
                    self?.cacher.save(places: places, key: key.key)
                    loadedPlaces[key.key] = places
                    key == keys.last! ? completion(loadedPlaces) : (/* move on */)
                }
            }
        }
    }
    
    /// Creates the request to Google Place API for getting place ids in radius 10 km, then parses got data and gets ids.
    /// Next, creates the request for getting detail info about all places around the key location, parses it and returns
    /// places in callback when the last place would be parsed or nil if something gets wrong
    func loadFromNet(with keyLocation: String, completion: @escaping ([Place]?)->()) {
        guard let req = requestFormatter.createIdUrlRequest(with: keyLocation) else { return }
        
        loader.load(with: req) { [weak self] data in
            guard let data = data, let placeIds = self?.parser.parseIds(with: data) else { return }
            var places: [Place] = []
            for id in placeIds {
                guard let placeReq = self?.requestFormatter.createPlaceRequest(with: id) else { return }
                self?.loader.load(with: placeReq) { data in
                    if let dat = data, let place = self?.parser.parsePlace(with: dat) {
                        places.append(place)
                        id == placeIds.last ? completion(places) : (/* move on */)
                    }
                }
            }
        }
    }
}
