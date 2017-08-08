//  DashboardController.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 7/31/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

class DashboardController: UIViewController {
    @IBOutlet weak var profileButton: RoundButton!
    @IBOutlet weak var placesButton: RoundButton!
    @IBOutlet weak var mapButton: RoundButton!
    @IBOutlet weak var weatherButton: RoundButton!
    @IBOutlet weak var settingsButton: RoundButton!
    
    // MARK: Animate buttons
    private func transformToIdentity(button: UIButton) {
        UIView.animate(withDuration: 1.0, animations: {
            button.transform = CGAffineTransform.identity
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileButton.transform = CGAffineTransform(scaleX: -0.95, y: 0.95)
        placesButton.transform =  CGAffineTransform(scaleX: -0.95, y: 0.95)
        mapButton.transform = CGAffineTransform(scaleX: -0.95, y: 0.95)
        weatherButton.transform = CGAffineTransform(scaleX: -0.95, y: 0.95)
        settingsButton.transform = CGAffineTransform(scaleX: -0.95, y: 0.95)
    }


    override func viewWillAppear(_ animated: Bool) {
        transformToIdentity(button: profileButton)
        transformToIdentity(button: placesButton)
        transformToIdentity(button: mapButton)
        transformToIdentity(button: weatherButton)
        transformToIdentity(button: settingsButton)
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.hidesBarsOnSwipe = false
       
    }
}

