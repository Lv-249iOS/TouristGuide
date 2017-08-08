//
//  Place.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/1/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation

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
}

class Place {
    var coordinates: [Double]?
    var formattedAddress: String?
    var internationalPhoneNumber: String?
    var name: String?
    var photosRef: [String]?
    var placeReviews: [Review]?
    var website: URL?
    var typeOfPlace: [String]?
    var openingHours: [String]?
    
    init(with json: AnyObject) {
        if let loc = json.value(forKeyPath: PlaceKeyPath.location.rawValue) as? [String: Double] {
            coordinates = getCoordinates(with: loc)
        }
        
        if let reviews = json.value(forKeyPath: PlaceKeyPath.placeReviews.rawValue) as? [[String: Any]] {
            placeReviews = getReviews(with: reviews)
        }
        
        if let refs = json.value(forKeyPath: PlaceKeyPath.imagesRef.rawValue) as? [String] {
            photosRef = getPhotoReferances(with: refs)
        }
        
        if let adress = json.value(forKeyPath: PlaceKeyPath.adress.rawValue) as? String {
           formattedAddress = adress
        }
        
        if let phoneNum = json.value(forKeyPath: PlaceKeyPath.phoneNum.rawValue) as? String {
            internationalPhoneNumber = phoneNum
        }
        
        if let placeName = json.value(forKeyPath: PlaceKeyPath.name.rawValue) as? String {
            name = placeName
        }

        if let workHours = json.value(forKeyPath: PlaceKeyPath.workHours.rawValue) as? [String] {
            openingHours = workHours
        }
        
        if let placeWebsite = json.value(forKeyPath: PlaceKeyPath.website.rawValue) as? String {
            website = URL(string: placeWebsite)
        }
        
        if let types = json.value(forKeyPath: PlaceKeyPath.typesOfPlace.rawValue) as? [String] {
            typeOfPlace = types
        }
    }
    
     private func getReviews(with jsonReviews: [[String: Any]]) -> [Review] {
         var placeReviews: [Review] = []
         
         for review in jsonReviews {
            let rev = Review(review: review)
            placeReviews.append(rev)
         }
         
         return placeReviews
     }
     
     private func getCoordinates(with jsonCoordinates: [String: Double]) -> [Double] {
         if let lat = jsonCoordinates["lat"], let lng = jsonCoordinates["lng"] {
            return [lat, lng]
         }
         
         return [0.0, 0.0]
     }
     
     private func getPhotoReferances(with jsonRefs: [String]) -> [String] {
         var photoUrls: [String] = []
         
         for ref in jsonRefs {
            let urlString = loadImgUrl + ref + "&key=" + key
            photoUrls.append(urlString)
         }
         
         return photoUrls
    }
}
