//
//  WeatherParse.swift
//  iTourist
//
//  Created by Andriy_Moravskyi on 8/4/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation
import UIKit

class WeatherParser {
    
    func parse(with data: Data) -> [Forecast]? {
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as AnyObject {
            var forecasts: [Forecast] = []
            var currentTemp = 0
            var feelsTemp = 0
            
            if let currentweather = json.value(forKeyPath: "current") as? [String: Any] {
                currentTemp = currentweather["temp_c"] as? Int ?? 0
                feelsTemp = currentweather["feelslike_c"] as? Int ?? 0
            }
            
            if let weather = json.value(forKeyPath: "forecast.forecastday") as? [AnyObject] {
                for dayWeath in weather {
                    var data: String?
                    if let datastring = dayWeath.value(forKeyPath: "date") as? String {
                        data = datastring
                    }
                    if let day = dayWeath.value(forKeyPath: "day") as? [String: Any] {
                        let forecast = Forecast(forecast: day)
                        forecast.date = data ?? ""
                        forecasts.append(forecast)
                    }
                }
                
                forecasts[0].currentTemp = currentTemp
                forecasts[0].feelsTemp = feelsTemp
            }
            return forecasts
        }
        
        return nil
    }
}
