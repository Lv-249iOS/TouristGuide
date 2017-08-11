//
//  RequestFormatter.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/10/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation

class UrlFormatter {
    
    let appKey = "AIzaSyCTy0OXO_Rx-QtOmIMyMeDOfxQdvPyRO8c"
    let loadIdOfPlaces = "https://maps.googleapis.com/maps/api/place/radarsearch/json?"
    let loadPlace = "https://maps.googleapis.com/maps/api/place/details/json?"
    let loadImgUrl = "https://maps.googleapis.com/maps/api/place/photo?"
    
    func createUrlForPlacesIdsReq(with locationKey: String, radius: Int = 10000, type: String = "point_of_interest") -> URL? {
        let location = "location=" + locationKey
        let rad = "radius=" + "\(radius)"
        let placeType = "type=" + type
        
        let urlString = loadIdOfPlaces + location + "&" + rad + "&" + placeType + "&key=" + appKey
        guard let url = URL(string: urlString) else { return nil }
        
        return url
    }
    
    func createUrlForPlaceDetailReq(with placeId: String) -> URL? {
        let urlString = loadPlace + "placeid=" + placeId + "&key=" + appKey
        guard let url = URL(string: urlString) else { return nil }
        
        return url
    }
    
    func createUrlForImageDownloading(with imgReference: String, maxwidth: Int = 1500) -> URL? {
        let maxWidth = "maxwidth=" + "\(maxwidth)"
        let reff = "photoreference=" + imgReference
        
        let urlString = loadImgUrl + maxWidth + "&" + reff + "&key=" + appKey
        guard let url = URL(string: urlString) else { return nil }
    
        return url
    }
}
