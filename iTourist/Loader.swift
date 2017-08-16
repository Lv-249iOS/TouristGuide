//
//  Loader.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/9/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import CoreLocation

class Loader {
    
    func load(with request: URLRequest, completion: @escaping (Data?)->()) {
        URLSession.shared.dataTask(with: request) { data, response, err in
            if let err = err {
                print(err)
                completion(nil)
            } else {
                completion(data)
            }
        }.resume()
    }
}
