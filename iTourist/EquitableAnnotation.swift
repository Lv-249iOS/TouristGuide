//
//  EquitableAnnotation.swift
//  AnotationOnMap
//
//  Created by AndreOsip on 8/7/17.
//  Copyright © 2017 AndreOsip. All rights reserved.
//

import Foundation
import MapKit

class EquitableAnnotation : NSObject, MKAnnotation {
//    let identifier = UUID().uuidString
    
    var coordinate = kCLLocationCoordinate2DInvalid
    
    var title: String?
    
    var subtitle: String?
    
    var type: String?
    
    var photoRef: String?
    
//    override var hashValue: Int {
//        return identifier.hashValue
//    }
//
//    public static func ==(lhs: EquatableAnnotation, rhs: EquatableAnnotation) -> Bool {
//        return lhs.identifier == rhs.identifier
//    }
    
}
