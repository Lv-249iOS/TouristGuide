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
    
    func save(places: [Place], key: String) {
        var placesData: [Data] = []
        let converter = DataConverter()
        
        for place in places {
            let dat = converter.convert(from: place)
            placesData.append(dat)
        }
        database.add(data: placesData as [NSData], key: key)
    }
    
    func getFromCache(with key: String) -> [Data]? {
        if let placesData = database.get(by: key) as [Data]? {
            return placesData
        }
        
        return nil
    }
    
    func removeFromCache(with key: String) {
        database.delete(for: key)
    }
    
    func updateCachedValue(with newVal: [Data], key: String) {
        //UserDefaults.standard.set(newVal, forKey: key)
    }
}
