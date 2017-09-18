//
//  MapFrameConverter.swift
//  iTourist
//
//  Created by AndreOsip on 8/14/17.
//  Copyright © 2017 AndreOsip. All rights reserved.
//

import MapKit
import CoreLocation

typealias RegionId = String

let converter = CoordinateConverter()

class MapFrameConverter {
    static func convert(region: MKCoordinateRegion) -> [CLLocation] {

        var locationsCenters: [CLLocation] = []
        
        if region.span.latitudeDelta >= 0.17 {
            
            let region = region
            let leftLo = region.center.longitude - region.span.longitudeDelta/2
            let topLa = region.center.latitude - region.span.latitudeDelta/2
            
            let rightLo = region.center.longitude + region.span.longitudeDelta/2
            let botLa = region.center.latitude + region.span.latitudeDelta/2
            
            let lat = round(topLa * 100) / 100
            let long = round(leftLo * 100) / 100
            
            for latitude in stride(from: lat, through: botLa, by: 0.14) {
                for longitude in stride(from: long, through: rightLo, by: 0.20) {
                    
                    let center = CLLocationCoordinate2D(latitude: latitude+0.07, longitude: longitude+0.1)
                    let location = CLLocation(latitude: center.latitude, longitude: center.longitude)
                    
                    locationsCenters.append(location)
                }
            }
        } else {
            let location = CLLocation(latitude: region.center.latitude, longitude: region.center.longitude)
            locationsCenters.append(location)
        }
        
        return locationsCenters
    }
    
    static func convert(id: RegionId) -> MKCoordinateRegion {
        
        return MKCoordinateRegion(center: (converter.converteToLocation(with: id)?.coordinate ?? kCLLocationCoordinate2DInvalid),
                                  span: MKCoordinateSpan(latitudeDelta: AppModel.shared.constants.defaultRegionSpan,
                                                         longitudeDelta: AppModel.shared.constants.defaultRegionSpan))
    }
    
    static func MKMapRectForCoordinateRegion(region:MKCoordinateRegion) -> MKMapRect {
        let topLeft = CLLocationCoordinate2D(latitude: region.center.latitude + (region.span.latitudeDelta/2), longitude: region.center.longitude - (region.span.longitudeDelta/2))
        let bottomRight = CLLocationCoordinate2D(latitude: region.center.latitude - (region.span.latitudeDelta/2), longitude: region.center.longitude + (region.span.longitudeDelta/2))
        
        let a = MKMapPointForCoordinate(topLeft)
        let b = MKMapPointForCoordinate(bottomRight)
        
        return MKMapRect(origin: MKMapPoint(x:min(a.x,b.x), y:min(a.y,b.y)), size: MKMapSize(width: abs(a.x-b.x), height: abs(a.y-b.y)))
    }
}
