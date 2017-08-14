//
//  CoordinateConverter.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/9/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import CoreLocation

class CoordinateConverter {
    
    func converteToKey(with location: CLLocation) -> String {
        //let lat = round(location.coordinate.latitude * 100) / 100
        //let long = round(location.coordinate.longitude * 100) / 100
        
        let key = "\(location.coordinate.latitude)" + "," + "\(location.coordinate.longitude)"
        
        return key
    }
    
    func converteToLocation(with key: String) -> CLLocation? {
        let coordinate: [String] = key.characters.split{ $0 == "," }.map(String.init)
        
        guard let lat = Double(coordinate[0]), let long = Double(coordinate[1]) else { return nil }
        let location = CLLocation(latitude: lat, longitude: long)
        
        return location
    }
}
