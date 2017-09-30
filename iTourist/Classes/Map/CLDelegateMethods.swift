//
//  CLDelegateMethods.swift
//  iTourist
//
//  Created by AndreOsip on 8/2/17.
//  Copyright © 2017 AndreOsip. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit


extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let currentLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(currentLocation, span)
        
        map.setRegion(region, animated: true)
        //map.showsUserLocation = true
        
        recalculatingToTheFirstPoint()
        print("there was update")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        map.showsUserLocation = (status == .authorizedWhenInUse || status == .authorizedAlways)
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
        manager.stopMonitoring(for: region)
        
        let annotation = selectedAnnotations[0]
        selectedAnnotations.remove(at: 0)
        
        map.removeAnnotation(annotation)
        map.addAnnotation(annotation)
        
        if let firstLine = lineOverlays.first, let circle = circleOverlay {
            map.remove(firstLine)
            
            lineOverlays.remove(at: 0)
            
            recalculatingToTheFirstPoint()
            
            map.remove(circle)
            addCircleOnFirstPoint()
        }
        
    }
    
    
}
