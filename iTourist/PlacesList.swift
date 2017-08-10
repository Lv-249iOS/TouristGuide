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
    var places: [Place]?
    
    func getPlaces(with startingPoint: CLLocation, completion: @escaping ([Place]?)->()) {
        print("INIT LIST")
        let id = CoordinateConverter().converteToKey(with: startingPoint)
        DataProvider.shared.getData(with: id) { result in
            self.places = result
            completion(self.places)
        } 
    }
    
    func add(place: Place) {
        places?.append(place)
    }
    
    func remove(at index: Int) {
        places?.remove(at: index)
    }
}
