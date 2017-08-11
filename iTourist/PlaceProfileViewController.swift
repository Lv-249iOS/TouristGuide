//
//  PlaceProfileViewController.swift
//  iTourist
//
//  Created by Zhanna Moskaliuk on 8/10/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

class PlaceProfileViewController: UIViewController {
    
    var place: Place?
    var placesPageController: PlacesPageController!
    @IBOutlet weak var phoneNumLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var workHourLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var feedbackButton: UIButton!
    @IBOutlet weak var nameNavigationItem: UINavigationItem!
    
    
    @IBAction func closePlaceProfile(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let place = place {
            nameNavigationItem.title = place.name
            adressLabel.text = place.formattedAddress
            phoneNumLabel.text = place.internationalPhoneNumber
            
            if let work = place.openingHours {
                workHourLabel.text = (work[0] + "\n" + work[1] + "\n" + work[2] + "\n" + work[3] + "\n" + work[4] + "\n" + work[5] + "\n" + work[6])
            }
            
            websiteLabel.text = place.website?.absoluteString
            feedbackButton.titleLabel?.text = "Feedbacks (\(String(describing: place.placeReviews?.count)))"
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlacesPageControllerSegue" , let controller = segue.destination as? PlacesPageController {
            placesPageController = controller
            placesPageController.imagesStringUrl = place?.photosRef
        }
    }
}

