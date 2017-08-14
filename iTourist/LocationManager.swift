//
//  LocationManager.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/9/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import CoreLocation

class LocationManager {
    var manager = CLLocationManager()

    var location: CLLocation? {
        get {
            return manager.location
        }
    }
}
