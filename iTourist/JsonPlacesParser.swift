//
//  JsonPlacesParser.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/1/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation

class JsonPlacesParser {
    
    enum PlaceKeyPath: String {
        case location = "result.geometry.location"
        case adress = "result.formatted_address"
        case phoneNum = "result.international_phone_number"
        case name = "result.name"
        case imagesRef = "result.photos.photo_reference"
        case workHours = "result.opening_hours.weekday_text"
        case placeReviews = "result.reviews"
        case website = "result.website"
        case typesOfPlace = "result.types"
        case placeId = "place_id"
        case results = "results"
    }
    
    func parseIds(with data: Data) -> [String]? {
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as AnyObject,
            let places = json.value(forKey: PlaceKeyPath.results.rawValue) as? [AnyObject] {
            var placesId: [String] = []
            
            print("PARSING PLACES......")
            for place in places {
                if let id = place.value(forKeyPath: PlaceKeyPath.placeId.rawValue) as? String {
                    placesId.append(id)
                }
            }
            
            return placesId
        }
        
        return nil
    }
    
    func parsePlace(with data: Data) -> Place? {
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as AnyObject else {
            return nil
        }
        
        var placeData: [PlaceAttributes: Any] = [:]
        
        placeData[.location] = json.value(forKeyPath: PlaceKeyPath.location.rawValue) as? [String: Double]
        placeData[.reviews] = json.value(forKeyPath: PlaceKeyPath.placeReviews.rawValue) as? [[String: Any]]
        placeData[.imgRef] = json.value(forKeyPath: PlaceKeyPath.imagesRef.rawValue) as? [String]
        placeData[.adress] = json.value(forKeyPath: PlaceKeyPath.adress.rawValue) as? String
        placeData[.phoneNum] = json.value(forKeyPath: PlaceKeyPath.phoneNum.rawValue) as? String
        placeData[.name] = json.value(forKeyPath: PlaceKeyPath.name.rawValue) as? String
        placeData[.workHours] = json.value(forKeyPath: PlaceKeyPath.workHours.rawValue) as? [String]
        placeData[.website] = json.value(forKeyPath: PlaceKeyPath.website.rawValue) as? String
        placeData[.types] = json.value(forKeyPath: PlaceKeyPath.typesOfPlace.rawValue) as? [String]
        
        let place = Place(with: placeData)
        
        return place
    }
}
