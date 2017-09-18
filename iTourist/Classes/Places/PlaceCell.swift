//
//  PlaceCell.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/1/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

protocol MyCellDelegate: class {
    func cellInfoDidClicked(for place: Place)
}

class PlaceCell: UITableViewCell {
    
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var phoneNum: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    public weak var delegate: MyCellDelegate?
    private var _place: Place?
    
    @IBAction func presentPlaceProfile(_ sender: Any) {
        if let place = _place {
            delegate?.cellInfoDidClicked(for: place)
        }
    }
    
    public func configureCell(with place: Place) {
        self._place = place
        name.text = self._place?.name
        adress.text = self._place?.formattedAddress
        phoneNum.text = self._place?.internationalPhoneNumber
    }
}
