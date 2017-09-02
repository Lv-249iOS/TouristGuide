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
    
    private var places: [Place]?
    var annotationsOfPlaces: [PlaceAnnotation] = []
    var selectedAnnotations: [PlaceAnnotation] = []
    var visibleIds: [RegionId: [PlaceAnnotation]] = [:]
    
    var lineOverlays: [MKOverlay] = []
    var circleOverlay: MKOverlay?
    
    let imageLoader = ImageManager.shared
    
    let converter = CoordinateConverter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let span: MKCoordinateSpan = AppModel.shared.getSpan() ?? MKCoordinateSpanMake(0.01, 0.01)
        if let location = AppModel.shared.location {
            let region: MKCoordinateRegion = MKCoordinateRegionMake(location.coordinate, span)
            map.setRegion(region, animated: true)
        }
        
        map.delegate = self
        map.showsUserLocation = true
        addUserLocationOnMap()
        
        print("PREVIEW")
        PlacesList.shared.getPlaces(with: [AppModel.shared.getLocation()]) { [weak self] places in
            print("MAP START GET PLACES")
            guard let placesArr = places else { return }
            for (key, places) in placesArr {
                guard let places = places else { return }
                self?.places = places
                for place in places {
                    let annotation = PlaceAnnotation()
                    
                    if let coordinates = place.coordinate {
                        annotation.coordinate = CLLocationCoordinate2DMake(coordinates[0], coordinates[1])
                    }
                    
                    annotation.title = place.name
                    annotation.subtitle = "\(place.typeOfPlace?.first ?? "") \(place.internationalPhoneNumber ?? "")"
                    annotation.photoRef = place.photosRef?.first
                    annotation.type = place.typeOfPlace?.first
                    self?.annotationsOfPlaces.append(annotation)
                    self?.map.addAnnotation(annotation)
                    print("Add annotation")
                }
            
                self?.visibleIds[key] = self?.annotationsOfPlaces
                self?.annotationsOfPlaces = []
                
            }

        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier  == "PlacesTypeSegue" {
            
            guard let annotationView = sender as? MKAnnotationView else { return }
            if let viewController = segue.destination as? PlaceProfileViewController {
                for place in places ?? [] {
                    if place.name == (annotationView.annotation?.title)! {
                        viewController.place = place
                        viewController.title = place.name
                    }
                }
            }
        }
    }
    
    
    
    @IBAction func calculateRoutes(_ sender: UIButton) {
        //it means if there is a route, alredy presented
        if let circle = circleOverlay {
            
            map.remove(circle)
            map.removeOverlays(lineOverlays)
            circleOverlay = nil
            
            for annot in selectedAnnotations {
                map.removeAnnotation(annot)
                map.addAnnotation(annot)
            }
            
            routeImage.image = nil
            routeInfo.text = nil
            selectedAnnotations = []
            routeButton.setImage(#imageLiteral(resourceName: "start"), for: .normal)
            
        } else {
            if !selectedAnnotations.isEmpty {
                presentRoute(sourse: ((AppModel.shared.locationManager.manager.location?.coordinate) ?? (selectedAnnotations[0].coordinate)) , dest: (selectedAnnotations[0].coordinate))
                
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
    
    
    func addUserLocationOnMap() {
        if CLLocationManager.locationServicesEnabled() {
            let status = CLLocationManager.authorizationStatus()
            
            if status == .authorizedAlways || status == .authorizedWhenInUse {
                AppModel.shared.locationManager.manager.delegate = self
                AppModel.shared.locationManager.manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                AppModel.shared.locationManager.manager.distanceFilter = 100.0
                //AppModel.shared.locationManager.manager.startUpdatingLocation()
            }
        }
    }
}
