//
//  DataProvider.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/9/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation

class DataProvider {
    
    static var shared = DataProvider()
    
    var cache = Cacher()
    var loader = Loader()
    var places: [Place] = []
    
    func getData(with placeId: String, completion: @escaping ([Place]?)->()) {
        print("GET DATA ------ DATA PROVIDER")
        if let _ = cache.getFromCache(with: placeId) {
            print("FROM CCHE")
            // we get [data] and should convert
        } else {
            print("FROM LOADER")
            if places.count != 0 {
                completion(places)
            }
            
            loader.loadData(with: placeId) { data, err in
                guard let data = data else { return }
                for dat in data {
                    guard let place = JsonPlacesParser().parsePlace(with: dat) else { return }
                    self.places.append(place)
                }
                
                completion(self.places)
            }
        }
    }
}
