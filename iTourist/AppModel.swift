//
//  AppModel.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/9/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import MapKit

class AppModel {
    
    static var shared = AppModel()
    
    var location: CLLocation?
    var bound: CGRect?
    
    var locationManager = LocationManager()
    var constants: Constants?
    
    init() {
        location = locationManager.location
        bound = Constants().bounds
    }
    
    func updateCoordinate(with coordinate: CLLocation) {
        // if center of visible map is changed
    }
    
    func updateBound(with bound: CGRect) {
        // if bounds is moved or scaled
    }
    
    func getCurrentLocation() -> CLLocation {
        print("GET CURR LOCATION")
        if let loc = location {
            return loc
        } else {
            return CLLocation(latitude: 49.839975, longitude: 24.028027) // return lviv as default
        }
    }
    
    func getVisibleRect() -> CGRect? {
        return bound
    }
}
