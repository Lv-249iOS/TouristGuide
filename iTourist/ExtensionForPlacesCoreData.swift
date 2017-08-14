//
//  ExtensionForPlacesCoredata.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/14/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation

extension PlaceEntity {
    var dataArray: [Data] {
        get {
            return data as? Array<Data> ?? []
        }
        set {
            data = newValue as NSArray
        }
    }
}
