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
        let key = "\(location.coordinate.latitude)" + "," + "\(location.coordinate.longitude)"
        print("CONVERT TO KEY")
        
        return key
    }
    
    func converteToLocation(with key: String) -> CLLocation? {
        print("CONVERT TO LOCATION")
        let coordinate: [String] = key.characters.split{ $0 == "," }.map(String.init)
        
        guard let lat = Double(coordinate[0]), let long = Double(coordinate[1]) else { return nil }
        let location = CLLocation(latitude: lat, longitude: long)
        
        return location
    }
}
