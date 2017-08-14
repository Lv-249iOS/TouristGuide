//
//  MVDelegateMethods.swift
//  iTourist
//
//  Created by AndreOsip on 8/2/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation
import MapKit

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil } else {
            let identifier = "Reuse"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            //will have to change it when conwerter is going to be ok
            
            let id = converter.converteToKey(with: AppModel.shared.getCurrentLocation())
            
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                
                guard let annotation = annotation as? PlaceAnnotation else { return annotationView }
                
                if let index = visibleIds[id]?.index(of: annotation) {
                    if let image = UIImage(named: visibleIds[id]?[index].type ?? "pin") {
                        annotationView?.image = image
                    } else {
                        annotationView?.image = UIImage(named: "pin")
                    }
                }
                
            } else {
                annotationView?.annotation = annotation
                guard let annotation = annotation as? PlaceAnnotation else { return annotationView }
                if let index = visibleIds[id]?.index(of: annotation) {
                    if let image = UIImage(named: visibleIds[id]?[index].type ?? "pin") {
                        annotationView?.image = image
                    } else {
                        annotationView?.image = UIImage(named: "pin")
                    }
                }
            }
            
            return annotationView
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if !(view.annotation is MKUserLocation) {
            let leftAccessory = UIButton(type: .custom)
            leftAccessory.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
            
            let id = converter.converteToKey(with: AppModel.shared.getCurrentLocation())
            
            if let annotation = view.annotation as? PlaceAnnotation {
                if let index = visibleIds[id]?.index(of: annotation) {
                    if let url = visibleIds[id]?[index].photoRef {
                        imageLoader.obtainImage(with: url) { image in
                            leftAccessory.setImage(image, for: .normal)
                            view.leftCalloutAccessoryView = leftAccessory
                        }
                    }
                }
            }
            
            let image = #imageLiteral(resourceName: "plus-minus-01-512")
            let rightAccessory = UIButton(type: .custom)
            
            rightAccessory.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            rightAccessory.setImage(image, for: .normal)
            view.rightCalloutAccessoryView = rightAccessory
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.leftCalloutAccessoryView {
            print("LEFT")
            
            
            
            
            
        } else {
            control.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
                control.transform = CGAffineTransform.identity
            }, completion: nil)
            
            let text = view.annotation?.title ?? ""
            routeInfo.text = "Rresent route to " + (text ?? "Unknown")
            
            if view.image != #imageLiteral(resourceName: "selected") {
                routeImage.image = view.image
            } else {
                routeImage.image = nil
                routeInfo.text = nil
            }
            
            var annotationDeselected = false
            let annotation = view.annotation as? PlaceAnnotation
            
            if selectedAnnotations.contains(annotation!) {
                for i in 0..<selectedAnnotations.count {
                    if selectedAnnotations[i] == annotation {
                        selectedAnnotations.remove(at: i)
                        break;
                    }
                }
                
                let annotation = view.annotation
                map.removeAnnotation(annotation!)
                map.addAnnotation(annotation!)
                annotationDeselected = true
            }
            
            if !annotationDeselected {
                let image = #imageLiteral(resourceName: "selected")
                view.image = image
                selectedAnnotations.append(view.annotation! as! PlaceAnnotation)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let render = MKPolylineRenderer(overlay: overlay)
            render.strokeColor = UIColor.blue
            render.lineWidth = 5.0
            
            return render
            
        } else if overlay is MKCircle {
            let render = MKCircleRenderer(overlay: overlay)
            render.strokeColor = .red
            render.fillColor = .red
            render.alpha = 0.5
            
            return render
        }
        return MKOverlayRenderer()
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        // 1. Set Region to model
        
        
        // 2. Convert region to array of IDs
        // let ids = MapFrameConverter.convert(region: mapView.region)
        
        // 3. Send ids to DataProvider
        
        
        // 3.1 When data come:
        // 3.1.1 Get region from id: 
        // - if intersects - present it
        // - in not - skip
        
        
        // 4. Check visible ids if still visible
        visibleIds.forEach { (visibleRegionInfo) in
            let tileRegion = MapFrameConverter.convert(id: visibleRegionInfo.key)
            let visibleRegion = mapView.region
            
            let tileRect = MapFrameConverter.MKMapRectForCoordinateRegion(region: tileRegion)
            let visibleRect = MapFrameConverter.MKMapRectForCoordinateRegion(region: visibleRegion)
            
            let visible = MKMapRectIntersectsRect(tileRect, visibleRect)
            
            if !visible {
                // 4.1 Remove tile visibleRegionInfo
            }
        }
        
        
        var currentIds: [String] = []
        
        let leftUpperCorner = CGPoint(x: map.bounds.minX, y: map.bounds.minY)
        let leftUpperCornerCoordinates = mapView.convert(leftUpperCorner, toCoordinateFrom: mapView)
        
        let rightUpperCorner = CGPoint(x: map.bounds.maxX, y: map.bounds.minY)
        let rightUpperCornerCoordinates = mapView.convert(rightUpperCorner, toCoordinateFrom: mapView)
        
        let rightBottomCorner = CGPoint(x: map.bounds.maxX, y: map.bounds.maxY)
        let rightBottomCornerCoordinates = mapView.convert(rightBottomCorner, toCoordinateFrom: mapView)
        
        for i in stride(from: leftUpperCornerCoordinates.longitude, through: rightUpperCornerCoordinates.longitude, by: 0.2) {
            print("LOOP First \(i)")
            for j in stride(from: rightBottomCornerCoordinates.latitude, through: rightUpperCornerCoordinates.latitude, by: 0.2) {
                print("LOOP Second \(j)")
                
                let location = CLLocation(latitude: i, longitude: j)
                let id = converter.converteToKey(with: location)
                currentIds.append(id)
            }
        }
        
        for id in currentIds {
            if visibleIds[id] == nil {
                
                self.annotationsOfPlaces = []
                
                /*DataProvider.shared.getData(with: [id]) { result in
                    
                    /*for place in result ?? [:] {
                        let annotation = PlaceAnnotation()
                        if let coordinates = place[0].coordinate {
                            annotation.coordinate = CLLocationCoordinate2DMake(coordinates[0], coordinates[1])
                        }
                        annotation.title = place?[0].name
                        annotation.subtitle = "\(place?[0].typeOfPlace?.first ?? "") \(place?[0].internationalPhoneNumber ?? "")"
                        annotation.photoRef = place?[0].photosRef?.first
                        annotation.type = place?[0].typeOfPlace?.first
                        self.annotationsOfPlaces.append(annotation)
                        self.map.addAnnotation(annotation)
                    }
 
                    self.visibleIds[id] = self.annotationsOfPlaces*/
                }*/
                
            }
        }
        //        for visibleId in visibleIds.keys {
        //            if !(currentIds.contains(visibleId)) {
        //
        //                if let invisibleAnnotations = visibleIds[visibleId] {
        //                    for annotation in invisibleAnnotations {
        //                        map.removeAnnotation(annotation)
        //                    }
        //                }
        //
        //                visibleIds.removeValue(forKey: visibleId)
        //                
        //            }
        //        }
        
    }
}


