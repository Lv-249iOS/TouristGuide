//
//  MapFrameConverter.swift
//  iTourist
//
//  Created by AndreOsip on 8/14/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import MapKit
import CoreLocation

typealias RegionId = String

let converter = CoordinateConverter()

class MapFrameConverter {
    static func convert(region: MKCoordinateRegion) -> [CLLocation] {
        //var currentIds: [RegionId] = []
        //cicle
        var locationCenters: [CLLocation] = []
        
        let leftLo = region.center.longitude - region.span.longitudeDelta/2
        let rightLo = region.center.longitude + region.span.longitudeDelta/2
        let rightLa = region.center.latitude + region.span.latitudeDelta/2
        let button = region.center.latitude - region.span.latitudeDelta/2
        
        for i in stride(from: leftLo, through: rightLo, by: 0.02) {
            print("LOOP First \(i)")
            for j in stride(from: button, through: rightLa, by: 0.02) {
                print("LOOP Second \(j)")
                
                let location = CLLocation(latitude: i+0.01, longitude: j+0.01)
                //let id = converter.converteToKey(with: location)
                //currentIds.append(id)
                locationCenters.append(location)
            }
        }
        return locationCenters //["+42.01-83.65"]
    }
    
    static func convert(id: RegionId) -> MKCoordinateRegion {
        return MKCoordinateRegion(center: kCLLocationCoordinate2DInvalid ,
                                  span: MKCoordinateSpan(latitudeDelta: Constants.defaultRegionSpan,
                                                         longitudeDelta: Constants.defaultRegionSpan))
    }
    
    static func MKMapRectForCoordinateRegion(region:MKCoordinateRegion) -> MKMapRect {
        let topLeft = CLLocationCoordinate2D(latitude: region.center.latitude + (region.span.latitudeDelta/2), longitude: region.center.longitude - (region.span.longitudeDelta/2))
        let bottomRight = CLLocationCoordinate2D(latitude: region.center.latitude - (region.span.latitudeDelta/2), longitude: region.center.longitude + (region.span.longitudeDelta/2))
        
        let a = MKMapPointForCoordinate(topLeft)
        let b = MKMapPointForCoordinate(bottomRight)
        
        return MKMapRect(origin: MKMapPoint(x:min(a.x,b.x), y:min(a.y,b.y)), size: MKMapSize(width: abs(a.x-b.x), height: abs(a.y-b.y)))
    }
}
