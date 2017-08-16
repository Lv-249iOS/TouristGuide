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
            
            var id = ""
            guard let annotation = annotation as? PlaceAnnotation else { return (annotationView as? MKPinAnnotationView) }
            
            for (key, value) in visibleIds {
                if value.contains(annotation) {
                    id = key
                    break
                }
            }
            if id == "" { id = visibleIds.keys.first! }

            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                
                if let index = visibleIds[id]?.index(of: annotation) {
                    if let image = UIImage(named: visibleIds[id]?[index].type ?? "pin") {
                        annotationView?.image = image
                    } else {
                        annotationView?.image = UIImage(named: "pin")
                    }
                }
                
            } else {
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
            
            if let annotation = view.annotation as? PlaceAnnotation {
                var id = ""
                for (key, value) in visibleIds {
                    if value.contains(annotation) {
                        id = key
                        break
                    }
                }
                
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
                view.image = #imageLiteral(resourceName: "selected")
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
        
        func visible(id: RegionId)->Bool {
            
            let tileRegion = MapFrameConverter.convert(id: id)
            let visibleRegion = mapView.region
            
            let tileRect = MapFrameConverter.MKMapRectForCoordinateRegion(region: tileRegion)
            let visibleRect = MapFrameConverter.MKMapRectForCoordinateRegion(region: visibleRegion)
            
            return MKMapRectIntersectsRect(tileRect, visibleRect)
        }
        
        print(map.region.span)
        
        if map.region.span.latitudeDelta < 0.02 {
            
            if visibleIds.isEmpty { visibleIds = ["0.0,0.0":[]] }
            
            visibleIds.forEach { (visibleRegionInfo) in
                
                if !visible(id: visibleRegionInfo.key) {
                    // present
                    
                    let locations = MapFrameConverter.convert(region: map.region)
                    
                    PlacesList.shared.getPlaces(with: locations) { places in
                        print("MAP START GET PLACES")
                        guard let placesArr = places else { return }
                        for (key, places) in placesArr {
                            
                            guard let places = places else { return }
                            
                            for place in places {
                                let annotation = PlaceAnnotation()
                                
                                if let coordinates = place.coordinate {
                                    annotation.coordinate = CLLocationCoordinate2DMake(coordinates[0], coordinates[1])
                                }
                                
                                annotation.title = place.name
                                annotation.subtitle = "\(place.typeOfPlace?.first ?? "") \(place.internationalPhoneNumber ?? "")"
                                annotation.photoRef = place.photosRef?.first
                                annotation.type = place.typeOfPlace?.first
                                self.annotationsOfPlaces.append(annotation)
                                
                            }
                            
                            self.visibleIds[key] = self.annotationsOfPlaces
                            self.annotationsOfPlaces = []
                            
                        }
                        
                    }
                    
                    visibleIds.forEach { (visibleRegionInfo) in
                        
                        if visible(id: visibleRegionInfo.key) {
                            // present
                            for annotation in visibleRegionInfo.value {
                                map.addAnnotation(annotation)
                                print("Add annotation")
                            }
                        }
                    }
                    
                }
                
            }
            
        }
        visibleIds.forEach { (visibleRegionInfo) in
            
            if !visible(id: visibleRegionInfo.key) {
                // 4.1 Remove tile visibleRegionInfo
                for annotation in visibleRegionInfo.value {
                    map.removeAnnotation(annotation)
                    visibleIds.removeValue(forKey: visibleRegionInfo.key)
                }
            }
        }
        
    }
    
    
}


