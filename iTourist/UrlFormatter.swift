//
//  RequestFormatter.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/10/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation

class UrlFormatter {
    
    enum PlaceUrl: String {
        case appKey = "AIzaSyCEegHajDdmV0YaBb-1qpp-TyYjlAW-oCg"
        case loadIdOfPlaces = "https://maps.googleapis.com/maps/api/place/radarsearch/json?"
        case loadPlace = "https://maps.googleapis.com/maps/api/place/details/json?"
        case loadImgUrl = "https://maps.googleapis.com/maps/api/place/photo?"
    }
    
    enum WeatherUrl: String {
        case loadWeatheer = "http://api.apixu.com/v1/forecast.json?"
        case key = "c51487b2c3714e86be6142344173107"
    }
    
    func createUrlForPlacesIdsReq(with locationKey: String, radius: Int, type: String = "point_of_interest") -> URL? {
        let location = "location=" + locationKey
        let rad = "radius=" + "\(radius)"
        let placeType = "type=" + type
        
        let urlString = PlaceUrl.loadIdOfPlaces.rawValue + location + "&" + rad + "&" + placeType + "&key=" + PlaceUrl.appKey.rawValue
        guard let url = URL(string: urlString) else { return nil }
        
        return url
    }
    
    func createUrlForPlaceDetailReq(with placeId: String) -> URL? {
        let urlString = PlaceUrl.loadPlace.rawValue + "placeid=" + placeId + "&key=" + PlaceUrl.appKey.rawValue
        guard let url = URL(string: urlString) else { return nil }
        
        return url
    }
    
    func createUrlForImageDownloading(with imgReference: String, maxwidth: Int = 500) -> URL? {
        let maxWidth = "maxwidth=" + "\(maxwidth)"
        let reff = "photoreference=" + imgReference
        
        let urlString = PlaceUrl.loadImgUrl.rawValue + maxWidth + "&" + reff + "&key=" + PlaceUrl.appKey.rawValue
        guard let url = URL(string: urlString) else { return nil }
    
        return url
    }
    
    func createUrlForWeather(with city: String, daysCount: Int) -> URL? {
        let key = "key=" + WeatherUrl.key.rawValue
        let days = "&days=" + "\(daysCount)"
        let town = "&q=" + city
        
        let urlString = WeatherUrl.loadWeatheer.rawValue + key + days + town
        guard let url = URL(string: urlString) else { return nil }
        
        return url
    }
}
