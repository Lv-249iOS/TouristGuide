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
    
    func getData(with key: String, completion: @escaping ([Place]?)->()) {
        print("GET DATA ------ DATA PROVIDER")
        if let data = cache.getFromCache(with: key) {
            print("FROM CCHE")
            let converter = DataConverter()
            var places: [Place] = []
            for dat in data {
                if let place = converter.convert(data: dat) {
                    places.append(place)
                }
            }
            
            completion(places)
            
        } else {
            print("FROM LOADER")
            var places: [Place] = []
            
            loader.loadData(with: key) { data, err in
                guard let data = data else { return }
                for dat in data {
                    guard let place = JsonPlacesParser().parsePlace(with: dat) else { return }
                    places.append(place)
                }
                self.cache.save(places: places, key: key)
                completion(places)
            }
        }
    }
}
