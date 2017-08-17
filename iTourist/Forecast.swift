//
//  Forecast.swift
//  iTourist
//
//  Created by Andriy_Moravskyi on 8/4/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

class Forecast {
    
    var maxtemp = Int()
    var mintemp = Int()
    var date =  String()
    var currentTemp = Int()
    var feelsTemp = Int()
    var imagecode  = String()
    var image = UIImage()
    
    init(forecast: [String: Any]) {
        maxtemp = forecast["maxtemp_c"] as? Int ?? 0
        mintemp = forecast["mintemp_c"] as? Int ?? 0
        date  = forecast["date"] as? String ?? "Unknown"
        if let condition = forecast["condition"] as? [String: Any] {
            let icon  = condition["code"] as? Int ?? 0
            imagecode = String(icon)
            if let img = UIImage(named: imagecode + ".png") {
                image = img
            }
        }
    }
}
