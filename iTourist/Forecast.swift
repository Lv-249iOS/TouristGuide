//
//  Forecast.swift
//  iTourist
//
//  Created by Andriy_Moravskyi on 8/4/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

class Forecast {
    
    enum ForecastWeatherKeyPath: String {
        case condition = "condition"
        case code = "code"
        case mintemp = "mintemp_c"
        case date = "date"
        case day = "day"
        case maxtemp = "maxtemp_c"
    }
    
    var maxtemp: Int
    var mintemp: Int
    var date:  String
    var currentTemp: Int?
    var feelsTemp: Int?
    var imagecode: String?
    var image: UIImage?
    
    init(forecast: [String: Any]) {
        maxtemp = forecast[ForecastWeatherKeyPath.maxtemp.rawValue] as? Int ?? 0
        mintemp = forecast[ForecastWeatherKeyPath.mintemp.rawValue] as? Int ?? 0
        date  = forecast[ForecastWeatherKeyPath.date.rawValue] as? String ?? "Unknown"
        
        if let condition = forecast[ForecastWeatherKeyPath.condition.rawValue] as? [String: Any] {
            let icon  = condition[ForecastWeatherKeyPath.code.rawValue] as? Int ?? 0
            imagecode = String(icon)
            
            if let imgName = imagecode, let img = UIImage(named: imgName + ".png") {
                image = img
            }
        }
    }
}
