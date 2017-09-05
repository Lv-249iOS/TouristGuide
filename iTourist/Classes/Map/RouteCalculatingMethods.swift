//
//  RouteCalculatingMethods.swift
//  AnotationOnMap
//
//  Created by AndreOsip on 8/5/17.
//  Copyright © 2017 AndreOsip. All rights reserved.
//

import MapKit
import CoreLocation

extension MapViewController {

    func addCircleOnFirstPoint() {
        
        let region = CLCircularRegion(center: selectedAnnotations[0].coordinate, radius: 15, identifier: "First")
        region.notifyOnExit = false
        let circle = MKCircle(center: region.center, radius: region.radius)
        
        self.map.add(circle, level: .aboveRoads)
        self.circleOverlay = circle
        AppModel.shared.locationManager.manager.startMonitoring(for: region)
        
    }
    
    func recalculatingToTheFirstPoint() {
        if !self.lineOverlays.isEmpty && !selectedAnnotations.isEmpty {
            map.remove(lineOverlays[0])
            presentRoute(sourse: ((AppModel.shared.location?.coordinate) ?? selectedAnnotations[0].coordinate), dest: selectedAnnotations[0].coordinate)
        }
    }
    
    func presentRoutes() {
        for i in 0..<selectedAnnotations.count-1 {
            presentRoute(sourse: selectedAnnotations[i].coordinate, dest: selectedAnnotations[i+1].coordinate)
        }
    }
    
    func presentRoute(sourse: CLLocationCoordinate2D, dest: CLLocationCoordinate2D) {
        
        let sourseItem = MKMapItem(placemark: MKPlacemark(coordinate: sourse))
        let destItem = MKMapItem(placemark: MKPlacemark(coordinate: dest))
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourseItem
        directionRequest.destination = destItem
        directionRequest.transportType = .walking
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate(completionHandler: {
            responce, error in
            
            guard let responce = responce else {
                if let error = error {
                    print("Something whent wrong \(error)")
                }
                return
            }
            
            let route = responce.routes[0]
            self.map.add(route.polyline, level: .aboveRoads)
            
            if dest.latitude == self.selectedAnnotations.first?.coordinate.latitude && dest.longitude == self.selectedAnnotations.first?.coordinate.longitude {
                if self.lineOverlays.isEmpty {
                    self.lineOverlays.append(route.polyline)
                } else {
                    self.lineOverlays[0] = route.polyline
                }
            } else {
                self.lineOverlays.append(route.polyline)
            }
        })
    }



}
