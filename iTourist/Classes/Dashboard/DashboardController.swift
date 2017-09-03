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
    @IBOutlet weak var loginButton: ProfileButtonWithIcon!
    
    var appModel = AppModel.shared
    var settingsManager = SettingsManager.shared
    private var database = UserCoreData()
    
    @IBAction func pressedButton(_ sender: UIButton) {
        settingsManager.makeSoundIfNeeded()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Ask user about location
        configureLocationServices()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
        if UserDefaults.standard.isLoggedIn() {
            loginButton.alpha = 0
            loginButton.isHidden = true
            
            profileButton.imageView?.contentMode = .scaleAspectFit
            let email = UserDefaults.standard.getEmail()
            let currentUser = database.getUser(by: email)
            if let imageNSData = currentUser?.image {
                guard let image = UIImage.init(data: imageNSData as Data) else { return }
                profileButton.setImage(image, for: .normal)
            }
//            if let userName = currentUser?.name, let surname = currentUser?.surname {
//                profileButton.setTitle(userName + " " + surname, for: .normal)
//                profileButton.titleLabel?.text = userName + " " + surname
//                profileButton.titleLabel?.sizeToFit()
//            }
            
            profileButton.alpha = 1
            profileButton.isHidden = false
        } else {
            profileButton.alpha = 0
            profileButton.isHidden = true
            loginButton.alpha = 1
            loginButton.isHidden = false
        }
        backgroundImageView.image = settingsManager.currentBackgroundImage
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        settingsButton.setNeedsDisplay()
        profileButton.setNeedsDisplay()
        weatherButton.setNeedsDisplay()
        placesButton.setNeedsDisplay()
        loginButton.setNeedsDisplay()
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
