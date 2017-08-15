//
//  DataConverter.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/9/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation

class DataConverter {
    
    func convert(from place: Place) -> Data {
        let data = NSKeyedArchiver.archivedData(withRootObject: place)
        return data
    }
    
    func convert(from data: Data) -> [String]? {
        guard let ids = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String] else { return nil }
        return ids
    }
    
    func convert(data: Data) -> Place? {
        guard let place = NSKeyedUnarchiver.unarchiveObject(with: data) as? Place else { return nil }
        return place
    }
}
