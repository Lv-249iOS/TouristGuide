//
//  Place.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/1/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation

class Place: NSObject, NSCoding {
    
    var coordinate: [Double]?
    var formattedAddress: String?
    var internationalPhoneNumber: String?
    var name: String?
    var photosRef: [String]?
    var placeReviews: [Review]?
    var website: URL?
    var typeOfPlace: [String]?
    var openingHours: [String]?
    
    required init(coder decoder: NSCoder) {
        coordinate = decoder.decodeObject(forKey: PlaceAttributes.location.rawValue) as? [Double]
        formattedAddress = decoder.decodeObject(forKey: PlaceAttributes.adress.rawValue) as? String
        internationalPhoneNumber = decoder.decodeObject(forKey: PlaceAttributes.phoneNum.rawValue) as? String
        name = decoder.decodeObject(forKey: PlaceAttributes.name.rawValue) as? String
        photosRef = decoder.decodeObject(forKey: PlaceAttributes.imgRef.rawValue) as? [String]
        placeReviews = decoder.decodeObject(forKey: PlaceAttributes.reviews.rawValue) as? [Review]
        website = decoder.decodeObject(forKey: PlaceAttributes.website.rawValue) as? URL
        typeOfPlace = decoder.decodeObject(forKey: PlaceAttributes.types.rawValue) as? [String]
        openingHours = decoder.decodeObject(forKey: PlaceAttributes.workHours.rawValue) as? [String]
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(coordinate, forKey: PlaceAttributes.location.rawValue)
        aCoder.encode(formattedAddress, forKey: PlaceAttributes.adress.rawValue)
        aCoder.encode(internationalPhoneNumber, forKey: PlaceAttributes.phoneNum.rawValue)
        aCoder.encode(name, forKey: PlaceAttributes.name.rawValue)
        aCoder.encode(photosRef, forKey: PlaceAttributes.imgRef.rawValue)
        aCoder.encode(placeReviews, forKey: PlaceAttributes.reviews.rawValue)
        aCoder.encode(website, forKey: PlaceAttributes.website.rawValue)
        aCoder.encode(typeOfPlace, forKey: PlaceAttributes.types.rawValue)
        aCoder.encode(openingHours, forKey: PlaceAttributes.workHours.rawValue)
    }
    
    init(with info: [PlaceAttributes: Any]) {
        super.init()
        
        coordinate = getCoordinates(with: info[.location] as? [String: Double])
        placeReviews = getReviews(with: info[.reviews] as? [[String: Any]])
        photosRef = info[.imgRef] as? [String]
        formattedAddress = info[.adress] as? String
        internationalPhoneNumber = info[.phoneNum] as? String
        name = info[.name] as? String
        openingHours = info[.workHours] as? [String]
        website = info[.website] as? URL
        typeOfPlace = info[.types] as? [String]
    }
    
    private func getReviews(with rev: [[String: Any]]?) -> [Review]? {
        guard let reviews = rev else { return nil }
        var placeReviews: [Review] = []
        
        for review in reviews {
            let rev = Review(review: review)
            placeReviews.append(rev)
        }
        
        return placeReviews
    }
    
    private func getCoordinates(with jsonCoordinate: [String: Double]?) -> [Double] {
        if let coordinate = jsonCoordinate, let lat = coordinate["lat"], let lng = coordinate["lng"] {
            return [lat, lng]
        }
        
        return [0.0, 0.0]
    }
}
