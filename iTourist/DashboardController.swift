//  DashboardController.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 7/31/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit
import CoreLocation

class DashboardController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var profileButton: RoundButton!
    @IBOutlet weak var placesButton: RoundButton!
    @IBOutlet weak var mapButton: RoundButton!
    @IBOutlet weak var weatherButton: RoundButton!
    @IBOutlet weak var settingsButton: RoundButton!
    
    var appModel = AppModel.shared
    var styleManager = StyleManager.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        NotificationCenter.default.addObserver(self, selector: #selector(rotate), name: Notification.Name.UIDeviceOrientationDidChange, object: nil)
        
        
        // Ask user about location
        configureLocationServices()
    }
    
//    func rotate(){
//        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
//            placesButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi/2)
//            self.view.layoutIfNeeded()
//        }
//        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation){
//            //your code in portrait mode
//        }
//    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
        backgroundImageView.image = styleManager.currentBackgroundImage
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        settingsButton.setNeedsDisplay()
        profileButton.setNeedsDisplay()
        weatherButton.setNeedsDisplay()
        placesButton.setNeedsDisplay()
        mapButton.setNeedsDisplay()
    }
    
    func configureLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            let status = CLLocationManager.authorizationStatus()
            if status == .notDetermined {
                appModel.locationManager.manager.requestWhenInUseAuthorization()
            }
        }
    }
}
