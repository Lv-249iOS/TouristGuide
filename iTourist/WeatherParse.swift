//
//  WeatherParse.swift
//  iTourist
//
//  Created by Andriy_Moravskyi on 8/4/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation
import UIKit

enum WeatherKeyPath: String {
    case current = "current"
    case currentTemp = "temp_c"
    case feelslikeTemp = "feelslike_c"
    case forecastday = "forecast.forecastday"
    case date = "date"
    case day = "day"
    case error = "error"
}

class WeatherParser {
    
    func parse(with data: Data) -> [Forecast]?{
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as AnyObject {
            var forecasts: [Forecast] = []
            var currentTemp = 0
            var feelsTemp = 0
            if json.value(forKeyPath: WeatherKeyPath.error.rawValue) != nil {
                Constants.cityForWeatherParseExists = false
            }
            
            if let currentweather = json.value(forKeyPath: WeatherKeyPath.current.rawValue) as? [String: Any] {
                currentTemp = currentweather[WeatherKeyPath.currentTemp.rawValue] as? Int ?? 0
                feelsTemp = currentweather[WeatherKeyPath.feelslikeTemp.rawValue] as? Int ?? 0
            }
            
            if let weather = json.value(forKeyPath: WeatherKeyPath.forecastday.rawValue) as? [AnyObject] {
                for dayWeath in weather {
                    var data: String?
                    if let datastring = dayWeath.value(forKeyPath: WeatherKeyPath.date.rawValue) as? String {
                        data = datastring
                    }
                    if let day = dayWeath.value(forKeyPath: WeatherKeyPath.day.rawValue) as? [String: Any] {
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
