//
//  Constants.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/9/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

struct Constants {
    
    // Constants for map
    
    let startingSpan = 0.01
    let defaultRegionSpan = 0.27
    
    // Constant for weather
    var cityForWeatherParseExists = true
    static let isMakeSound = NSNotification.Name(rawValue: "MakeSoundChanged")
    
}
enum PathForSettingsKey: String {
       case sound = "isMakeSound"
       case userLocation = "isUseUserLocation"
       case sortPlaces = "isSortPlaces"
       case celcius = "isUseCelcius"
}
