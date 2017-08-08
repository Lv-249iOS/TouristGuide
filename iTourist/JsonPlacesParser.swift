//
//  JsonPlacesParser.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/1/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation

class JsonPlacesParser: Parser {
    
    func parseIdPlaces(with url: URL, completion: @escaping ([String]?, Error?)->()) {
        URLCacher.shared.getDataResponse(with: URLRequest(url: url)) { data, err in
            guard let  data = data else { return }
            if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as AnyObject {
                var placesId: [String] = []
                
                guard let places = json.value(forKey: "results") as? [AnyObject] else { return }
                for place in places {
                    if let id = place.value(forKeyPath: "place_id") as? String {
                        placesId.append(id)
                    }
                }
                completion(placesId, err)
            }
        }
    }

    func parse(with url: URL, completion: @escaping (Any?, Error?)->()) {
        parseIdPlaces(with: url) { placeIds, err in
            guard let idOfPlaces = placeIds else { return }
            var parsedPlaces: [Place] = []

            for placeId in idOfPlaces {
                self.parsePlace(with: placeId) { place in
                    if let parsedPlace = place {
                        parsedPlaces.append(parsedPlace)
                        
                        if placeId == idOfPlaces.last {
                            completion(parsedPlaces, err)
                        }
                    }
                }
            }
        }
    }
    
    func parsePlace(with placeId: String, completion: @escaping (Place?)->()) {
        guard let url = URL(string: loadPlace + placeId + "&key=" + key) else { return }
        
        URLCacher.shared.getDataResponse(with: URLRequest(url: url)) { data, err in
            guard let  data = data else { return }
            if let json  = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as AnyObject {
                let place = Place(with: json)
                completion(place)
            }
        }
    }
}
