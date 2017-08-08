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
            

            guard let annotation = annotation as? PlaceAnnotation else { return annotationView }

                if let index = annotationsOfPlaces.index(of: annotation) {
                    if let image = UIImage(named: annotationsOfPlaces[index].type!) {
                    annotationView?.image = image
                    
                    } else { annotationView?.image = UIImage(named: "pin") }
                
            }
         
        } else {
            annotationView?.annotation = annotation

            guard let annotation = annotation as? PlaceAnnotation else { return annotationView }

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
            
            if let annotation = view.annotation as? PlaceAnnotation {

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

    }


