//
//  Cacher.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/9/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation

class Cacher {
    
    var database = PlaceCoreData()
    let converter = DataConverter()
    
    func save(places: [Place], key: String) {
        var placesData: [Data] = []
        for place in places {
            let dat = converter.convert(from: place)
            placesData.append(dat)
        }
        
        database.add(data: placesData as [NSData], key: key)
        print("SAVED IN DATABASE")
    }
    
    func getFromCache(with key: String) -> [Place]? {
        guard let placesData = database.get(by: key) as [Data]? else { return nil }
        var places: [Place] = []
        for dat in placesData {
            if let place = converter.convert(data: dat) {
                places.append(place)
            }
        }
        
        return places
    }
    
    func removeFromCache(with key: String) {
        database.delete(for: key)
        print("REMOVED FROM DATABASE")
    }
    
    func updateCachedValue(with newVal: [Data], key: String) {
        // Some method that will be update data for some key
        print("VALUE WAS UPDATED IN DATABASE")
    }
}
