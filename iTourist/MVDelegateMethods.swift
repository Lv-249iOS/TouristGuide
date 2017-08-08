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
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            guard let annotation = annotation as? EquitableAnnotation else { return annotationView }
                if let index = annotationsOfPlaces.index(of: annotation) {
                    if let image = UIImage(named: annotationsOfPlaces[index].type!) {
                    annotationView?.image = image
                    
                    } else { annotationView?.image = UIImage(named: "pin") }
                
            }
         
        } else {
            annotationView?.annotation = annotation
            guard let annotation = annotation as? EquitableAnnotation else { return annotationView }
            if let index = annotationsOfPlaces.index(of: annotation) {
                if let image = UIImage(named: annotationsOfPlaces[index].type!) {
                    annotationView?.image = image
                    
                } else { annotationView?.image = UIImage(named: "pin") }
            }
            
            }
        
        return annotationView
        }
    }
    
    
    
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        if !(view.annotation is MKUserLocation) {
            
            let leftAccessory = UIButton(type: .custom)
            leftAccessory.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
            
            if let annotation = view.annotation as? EquitableAnnotation {
                if let index = annotationsOfPlaces.index(of: annotation) {
                    if let url = annotationsOfPlaces[index].photoRef
                    {
                        imageLoader.obtainImageWithPath(imagePath: url) { image in
                            leftAccessory.setImage(image, for: .normal)
                            view.leftCalloutAccessoryView = leftAccessory
                        }
                    }
                }
            }
 
            let im = #imageLiteral(resourceName: "noImage")
            let rightAccessory = UIButton(type: .custom)
            rightAccessory.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            rightAccessory.setImage(im, for: .normal)
            
            view.rightCalloutAccessoryView = rightAccessory
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.leftCalloutAccessoryView {
        print("LEFT")
        } else {print("RIGHT")}
    }
    
    
}
