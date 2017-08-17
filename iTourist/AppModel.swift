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
    var span: MKCoordinateSpan?
    
    var locationManager = LocationManager()
    var constants: Constants
    
    init() {
        location = locationManager.location
        constants = Constants()
        span = MKCoordinateSpanMake(constants.startingSpan, constants.startingSpan)
    }
    
    func updateLocation(with location: CLLocation) {
        // if center of visible map is changed
        self.location = location
    }
    
    func updateSpan(with span: MKCoordinateSpan) {
        // if bounds is moved or scaled
        self.span = span
    }
    
    func getLocation() -> CLLocation {
        print("GET CURR LOCATION")
        if let loc = location {
            return loc
        } else {
            return CLLocation(latitude: 49.839975, longitude: 24.028027) // return lviv as default
        }
    }
    
    func getSpan() -> MKCoordinateSpan? {
        return span
    }
}
