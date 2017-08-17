//
//  Constants.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/9/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

struct Constants {
    // delete it
    var bounds: CGRect
    
    // change it
    init() {
        bounds = UIScreen.main.bounds
    }
    static let defaultRegionSpan = 0.27
    static var cityForWeatherParseExists = true
    static let deviceSceenheight = UIScreen.main.bounds.height
    static let deviceSceenwidth = UIScreen.main.bounds.width
}
