//
//  PlacePrifileController.swift
//  iTourist
//
//  Created by Zhanna Moskaliuk on 8/3/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

class PlacePrifileController: UIViewController {
    var place: Place?
    
    @IBOutlet weak var phoneNumLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var workHourLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var feedbackButton: UIButton!
    @IBOutlet weak var nameNavigationItem: UINavigationItem!
    
    @IBAction func closePlaceProfile(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let plc = place {
            nameNavigationItem.title = plc.name
            adressLabel.text = plc.formattedAddress
            phoneNumLabel.text = plc.internationalPhoneNumber
            
            if let work = plc.openingHours {
                workHourLabel.text = (work[0] + "\n" + work[1] + "\n" + work[2] + "\n" + work[3] + "\n" + work[4] + "\n" + work[5] + "\n" + work[6])
            }
            
            websiteLabel.text = plc.website?.absoluteString
            feedbackButton.titleLabel?.text = "Feedbacks (\(plc.placeReviews?.count))"
        }
    }
}
