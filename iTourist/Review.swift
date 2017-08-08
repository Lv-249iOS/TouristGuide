//
//  Review.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/1/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation

enum ReviewKeys: String {
    case authorName = "author_name"
    case profilePhotoUrl = "profile_photo_url"
    case timeOfPosting = "time"
    case rating = "rating"
    case text = "text"
}

class Review {
    var authorName: String?
    var rating: Float?
    var timeDescription: Date?
    var text: String?
    
    init(review: [String: Any]) {
        authorName = review[ReviewKeys.authorName.rawValue] as? String ?? "Unknown"
        text = review[ReviewKeys.text.rawValue] as? String ?? "Unknown"
        rating = review[ReviewKeys.rating.rawValue] as? Float ?? 4.0

        if let time = review[ReviewKeys.timeOfPosting.rawValue] as? Double {
            timeDescription = Date(timeIntervalSince1970: time)
        }
    }
}

