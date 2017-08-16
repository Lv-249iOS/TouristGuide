//
//  RequestFormatter.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/11/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation

class RequestFormatter {
    
    // Request formatters for Google places API
    
    func createIdUrlRequest(with key: String, radius: Int = 10000) -> URLRequest? {
        guard let url = UrlFormatter().createUrlForPlacesIdsReq(with: key, radius: radius) else { return nil }
        return URLRequest(url: url)
    }
    
    func createPlaceRequest(with id: String) -> URLRequest? {
        guard let url = UrlFormatter().createUrlForPlaceDetailReq(with: id) else { return nil }
        return URLRequest(url: url)
    }
    
    func createImageRequest(with imgRef: String) -> URLRequest? {
        guard let url = UrlFormatter().createUrlForImageDownloading(with: imgRef) else { return nil }
        return URLRequest(url: url)
    }
    
    // Request formatter for Weather API
    
    func createWeatherRequest(with city: String, countOfDays: Int = 7) -> URLRequest? {
        guard let url = UrlFormatter().createUrlForWeather(with: city, daysCount: countOfDays) else { return nil }
        return URLRequest(url: url)
    }
}
