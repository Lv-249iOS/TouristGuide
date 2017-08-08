//
//  Forecast.swift
//  iTourist
//
//  Created by Andriy_Moravskyi on 8/4/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation


class Forecast {
    
    var maxtemp = Int()
    var mintemp = Int()
    var date =  String()
    var currentTemp = Int()
    var feelsTemp = Int()
    
    init(forecast: [String: Any]) {
        maxtemp = forecast["maxtemp_c"] as? Int ?? 0
        mintemp = forecast["mintemp_c"] as? Int ?? 0
        date  = forecast["date"] as? String ?? "qqqqqq"
    }
}
