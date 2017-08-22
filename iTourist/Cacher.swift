//
//  Cacher.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/9/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation
import CoreLocation

class Cacher {
    
    private var database = PlaceCoreData()
    private let converter = DataConverter()
    private let coordinateConverter = CoordinateConverter()
    
    /// Saves the array of places with the key in database converting it to [Data]
    func save(places: [Place], key: String) {
        var placesData: [Data] = []
        for place in places {
            let dat = converter.convert(from: place)
            placesData.append(dat)
        }
        
        database.add(data: placesData as [NSData], key: key)
        print("SAVED IN DATABASE")
    }
    
    /// If database has data with the key, returns converted data to [Place] else returns nil
    func getFromCache(with key: String) -> [Place]? {
        
        //dangerous code written by Andriy
        var rangeKey = ""
        let location = coordinateConverter.converteToLocation(with: key)
        for i in stride(from: (location?.coordinate.latitude)!-0.06, through: (location?.coordinate.latitude)!+0.06, by: 0.01) {
            for j in stride(from: (location?.coordinate.longitude)!-0.13, through: (location?.coordinate.longitude)!+0.13, by: 0.01) {
                let rangeLocation = CLLocation(latitude: i, longitude: j)
                rangeKey = coordinateConverter.converteToKey(with: rangeLocation)
                if let placesData = database.get(by: rangeKey) as [Data]? {
                    
                    var places: [Place] = []
                    for dat in placesData {
                        if let place = converter.convert(data: dat) {
                            places.append(place)
                        }
                    }
                    
                    return places
                }
            }
        }
        return nil
        
//        guard let placesData = database.get(by: key) as [Data]? else { return nil }
//        var places: [Place] = []
//        for dat in placesData {
//            if let place = converter.convert(data: dat) {
//                places.append(place)
//            }
//        }
//        
//        return places
        
    }
    
    func removeFromCache(with key: String) {
        database.delete(for: key)
        print("REMOVED FROM DATABASE")
    }
    
    func updateCachedValue(with newVal: [Data], key: String) {
        database.change(data: newVal as [NSData], by: key)
        print("VALUE WAS UPDATED IN DATABASE")
    }
}
