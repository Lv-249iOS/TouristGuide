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
    @IBOutlet weak var routeButton: UIButton!
    @IBOutlet weak var routeInfo: UILabel!
    @IBOutlet weak var routeImage: UIImageView!
    
    var annotationsOfPlaces: [PlaceAnnotation] = []
    var selectedAnnotations: [PlaceAnnotation] = []
    var visibleIds: [RegionId: [PlaceAnnotation]] = [:]
    var places: [Place]?
    
    var lineOverlays: [MKOverlay] = []
    var circleOverlay: MKOverlay?
    
    var imageLoader = ImageDownloader.shared
    
    let converter = CoordinateConverter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotation(gestureRecognizer:)))
        longPress.minimumPressDuration = 1.0
        map.addGestureRecognizer(longPress)
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        if let location = AppModel.shared.location {
            let region: MKCoordinateRegion = MKCoordinateRegionMake(location.coordinate, span)
            map.setRegion(region, animated: true)
        }
        
        map.delegate = self
        addUserLocationOnMap()
        
        print("PREVIEW")
        PlacesList.shared.getPlaces(with: [AppModel.shared.getCurrentLocation()]) { places in
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
                    self.map.addAnnotation(annotation)
                }
            
                self.visibleIds[key] = self.annotationsOfPlaces
                self.annotationsOfPlaces = []
                
            }

        }
    }
    
    @IBAction func calculateRoutes(_ sender: UIButton) {
        if let circle = circleOverlay {
            map.remove(circle)
            map.removeOverlays(lineOverlays)
            circleOverlay = nil
            let reloadingAnnotations = selectedAnnotations
            for annot in reloadingAnnotations {
                map.removeAnnotation(annot)
                map.addAnnotation(annot)
            }
            
            selectedAnnotations = []
            routeButton.setImage(#imageLiteral(resourceName: "start"), for: .normal)
        } else {
            if !selectedAnnotations.isEmpty {
                // remove !!!!
                presentRoute(sourse: (AppModel.shared.locationManager.manager.location?.coordinate)!, dest: (selectedAnnotations[0].coordinate))
                addCircleOnFirstPoint()
                presentRoutes()
                routeButton.setImage(#imageLiteral(resourceName: "clean"), for: .normal)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func longPressHandler(_action: UIAlertAction) {
        print("HANDLER")
    }
    
    func addAnnotation(gestureRecognizer:UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            
            let alert = UIAlertController(title: "Do you want to create a new place?", message: "you would have to add some information", preferredStyle:UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK",style: UIAlertActionStyle.default, handler: longPressHandler(_action: )))
            alert.addAction(UIAlertAction(title: "Cancel",style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func addUserLocationOnMap() {
        if CLLocationManager.locationServicesEnabled() {
            let status = CLLocationManager.authorizationStatus()
            
            if status == .authorizedAlways || status == .authorizedWhenInUse {
                AppModel.shared.locationManager.manager.delegate = self
                AppModel.shared.locationManager.manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                AppModel.shared.locationManager.manager.distanceFilter = 100.0
                AppModel.shared.locationManager.manager.startUpdatingLocation()
            }
        }
    }
}
