//
//  PlacesList.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/9/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import CoreLocation

class PlacesList {
    
    static var shared = PlacesList()
    
    func getPlaces(with startingPoint: CLLocation, completion: @escaping ([Place]?)->()) {
        let key = CoordinateConverter().converteToKey(with: startingPoint)
        DataProvider.shared.getData(with: key) { result in
            print("GOT FROM  DATA PROVIDER")
            completion(result)
        }
    }
    
    func add(place: Place) {
        // places?.append(place)
    }
    
    func remove(at index: Int) {
        // places?.remove(at: index)
    }
}
