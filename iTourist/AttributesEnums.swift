//
//  PlaceAttributesEnum.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/10/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation

enum PlaceAttributes: String {
    case location = "coordinate"
    case adress   = "formattedAddress"
    case phoneNum = "internationalPhoneNumber"
    case name = "name"
    case imgRef = "photosRef"
    case workHours = "placeReviews"
    case reviews = "website"
    case website = "typeOfPlace"
    case types = "openingHours"
}

enum ReviewAttributes: String {
    case authorName = "author_name"
    case timeOfPosting = "time"
    case rating = "rating"
    case text = "text"
}
