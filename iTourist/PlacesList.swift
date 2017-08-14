//
//  PlacesList.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/9/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import CoreLocation

class PlacesList {
    
    static var shared = PlacesList()
    
    func getPlaces(with locations: [CLLocation], completion: @escaping ([RegionId: [Place]?]?)->()) {
        DataProvider.shared.getData(with: getKeys(from: locations)) { result in
            print("GOT FROM  DATA PROVIDER")
            completion(result)
        }
    }
    
    private func getKeys(from locations: [CLLocation]) -> [(key: String, loc: String)] {
        let converter = CoordinateConverter()
        var keys: [(key: String, loc: String)] = []

        for loc in locations {

            let key = (key: converter.converteToKey(with: loc), loc: converter.converteToString(from: loc))
            keys.append(key)
        }
        
        return keys
    }
    
    func add(place: Place) {
        // places?.append(place)
    }
    
    func remove(at index: Int) {
        // places?.remove(at: index)
    }
}
