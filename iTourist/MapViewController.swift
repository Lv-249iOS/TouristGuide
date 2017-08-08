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
    
    var places: [Place] = []
    var annotationsOfPlaces: [EquitableAnnotation] = []
    var imageLoader = ImageCacheLoader()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let region: MKCoordinateRegion = MKCoordinateRegionMake((CLLocationManager().location?.coordinate)!, span)
        
        map.setRegion(region, animated: true)
        
        manager.delegate = self
        map.delegate = self
        
        configureLocationServices()
        
        let parser = JsonPlacesParser()
        guard let url = URL(string: loadIdOfPlaces) else { return }
        
        parser.parse(with: url) { places, err in
            if let plc = places as? [Place] {
                DispatchQueue.main.async {
                    self.places = plc
                    
                    for place in self.places {
                        let annotation = EquitableAnnotation()
                        annotation.coordinate = CLLocationCoordinate2DMake((place.coordinates?[0])!, (place.coordinates?[1])!)
                        annotation.title = place.name
                        annotation.subtitle = "\(place.typeOfPlace?.first ?? "") \(place.internationalPhoneNumber ?? "")"
                        annotation.photoRef = place.photosRef?.first
                        annotation.type = place.typeOfPlace?.first
                        self.annotationsOfPlaces.append(annotation)
                    }
                    self.map.addAnnotations(self.annotationsOfPlaces)
                }
            }
        }
        
//        for place in places {
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = CLLocationCoordinate2DMake((place.coordinates?[0])!, (place.coordinates?[1])!)
//            annotation.title = "MY STAFF"
//            map.addAnnotation(annotation)
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
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
