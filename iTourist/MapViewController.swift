//
//  MapViewController.swift
//  iTourist
//
//  Created by Zhanna Moskaliuk on 8/1/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var map: MKMapView!
    var manager = CLLocationManager()
    
    var annotationsOfPlaces: [PlaceAnnotation] = []
    var selectedAnnotations :[PlaceAnnotation] = []
    
    var lineOverlays: [MKOverlay] = []
    var circleOverlay: MKOverlay?
    
    var imageLoader = ImageDownloader()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotation(gestureRecognizer:)))
        longPress.minimumPressDuration = 1.0
        map.addGestureRecognizer(longPress)
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        if let location = CLLocationManager().location {
            let region: MKCoordinateRegion = MKCoordinateRegionMake(location.coordinate, span)
            map.setRegion(region, animated: true)
        }
        
        manager.delegate = self
        map.delegate = self
        
        configureLocationServices()
        
        PlacesManager.shared.getPlaces() {
            for place in PlacesManager.shared.listOfPlaces {
                let annotation = PlaceAnnotation()
                if let coordinates = place.coordinates {
                    annotation.coordinate = CLLocationCoordinate2DMake(coordinates[0], coordinates[1])
                }
                annotation.title = place.name
                annotation.subtitle = "\(place.typeOfPlace?.first ?? "") \(place.internationalPhoneNumber ?? "")"
                annotation.photoRef = place.photosRef?.first
                annotation.type = place.typeOfPlace?.first
                self.annotationsOfPlaces.append(annotation)
            }
            self.map.addAnnotations(self.annotationsOfPlaces)
        }
    }
    
    @IBAction func calculateRoutes(_ sender: UIButton) {
        if !selectedAnnotations.isEmpty {
            
            if let circle = circleOverlay {
                map.remove(circle)
                map.removeOverlays(lineOverlays)
            }
            
            presentRoute(sourse: (manager.location?.coordinate)!, dest: (selectedAnnotations[0].coordinate))
            
            addCircleOnFirstPoint()
            
            presentRoutes()
        }
    }
    
    @IBAction func clearRoutes(_ sender: UIButton) {
        if let circle = circleOverlay {
            map.remove(circle)
            map.removeOverlays(lineOverlays)
        }

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func handler(_action: UIAlertAction) {
        print("HANDLER")
    }
    
    func addAnnotation (gestureRecognizer:UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            var hand: ((UIAlertAction)->Void)?
            hand = handler(_action: )
            
            let alert = UIAlertController(title:"Do you want to create a new place?", message:"you would have to add some information", preferredStyle:UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title:"OK",style: UIAlertActionStyle.default, handler:hand))
            alert.addAction(UIAlertAction(title:"Cancel",style: UIAlertActionStyle.default, handler:nil))
            self.present(alert, animated:true, completion:nil)
        }
    }

    
    func configureLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            let status = CLLocationManager.authorizationStatus()
            
            if status == .notDetermined {
                manager.requestWhenInUseAuthorization()
            } else {
                
                switch status {
                case .authorizedAlways: fallthrough
                case .authorizedWhenInUse:
                    manager.delegate = self
                    manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                    manager.distanceFilter = 100.0
                    manager.startUpdatingLocation()
                    
                default:
                    print("Appears that there are some problems with getting location")
                    
                }
            }
        } else {
            print("Location servises is not avalible")
        }
    }
}
