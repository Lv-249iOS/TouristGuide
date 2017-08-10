//
//  PlacesManager.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/8/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation

class PlacesManager {
    static var shared = PlacesManager()
    var listOfPlaces: [Place] = []
    
    func getPlaces(completion: @escaping ()->()) {
        /*if listOfPlaces.count != 0 {
            completion()
        } else if 1 == 2 /*we have something in db*/ {
            // get from db
            //completion()
        } else {
            let parser = JsonPlacesParser()
            guard let url = URL(string: loadIdOfPlaces) else { return }
            
            parser.parse(with: url) { places, err in
                if let plc = places as? [Place] {
                    self.listOfPlaces = plc
                }
                
                completion()
            }
        }*/
    }
    
    func add(place: Place) {
        listOfPlaces.append(place)
    }
    
    func remove(at index: Int) {
        listOfPlaces.remove(at: index)
    }
}
