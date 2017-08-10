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
        print("Step in APP MODEL")
        constants = Constants()
        print("get frame")
        
        if let loc = locationManager.getLocation() {
            location = loc 
        }
        
        bound = constants?.bounds
        print("STEP OUT MODEL")
    }
    
    func updateCoordinate(with coordinate: CLLocation) {
        // if center of visible map is changed
    }
    
    func updateBound(with bound: CGRect) {
        // if bounds is moved or scaled
    }
    
    func getCurrentLocation() -> CLLocation {
        print("FUNC GET CURRENT LOCATION")
        if let loc = location {
            return loc
        } else {
            return CLLocation(latitude: 49.839975, longitude: 24.028027) // return lviv as default
        }
    }
    
    func getVisibleRect() -> CGRect? {
        print("FUNC GET CURRENT getVisibleRect")
        return bound
    }
}
