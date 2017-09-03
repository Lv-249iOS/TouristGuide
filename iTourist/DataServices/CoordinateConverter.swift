//
//  CoordinateConverter.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/9/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import CoreLocation

class CoordinateConverter {
    
    /// Use this method if you need generate the key from rounded location
    func converteToKey(with location: CLLocation) -> String {
        let lat = round(location.coordinate.latitude * 100) / 100
        let long = round(location.coordinate.longitude * 100) / 100
        
        let key = "\(lat)" + "," + "\(long)"
        
        return key
    }
    
    /// Use this method if you need generate the location string separated dy koma
    func converteToString(from loc: CLLocation) -> String {
        let locStr = "\(loc.coordinate.latitude)" + "," + "\(loc.coordinate.longitude)"
        
        return locStr
    }
    
    /// Use if need converte string key to CLLocation
    func converteToLocation(with key: String) -> CLLocation? {
        let coordinate: [String] = key.characters.split{ $0 == "," }.map(String.init)
        guard let lat = Double(coordinate[0]), let long = Double(coordinate[1]) else { return nil }
        
        let location = CLLocation(latitude: lat, longitude: long)
        
        return location
    }
}
