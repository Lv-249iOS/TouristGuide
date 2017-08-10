//
//  Review.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/1/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation

class Review: NSObject, NSCoding {
    
    var authorName: String?
    var rating: Float?
    var timeDescription: Date?
    var text: String?
    
    required init(coder decoder: NSCoder) {
        authorName = decoder.decodeObject(forKey: ReviewAttributes.authorName.rawValue) as? String
        rating = decoder.decodeObject(forKey: ReviewAttributes.rating.rawValue) as? Float
        timeDescription = decoder.decodeObject(forKey: ReviewAttributes.timeOfPosting.rawValue) as? Date
        text = decoder.decodeObject(forKey: ReviewAttributes.text.rawValue) as? String
    }
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(authorName, forKey: ReviewAttributes.authorName.rawValue)
        aCoder.encode(rating, forKey: ReviewAttributes.rating.rawValue)
        aCoder.encode(timeDescription, forKey: ReviewAttributes.timeOfPosting.rawValue)
        aCoder.encode(text, forKey: ReviewAttributes.text.rawValue)
    }
    
    init(review: [String: Any]) {
        super.init()
        
        authorName = review[ReviewAttributes.authorName.rawValue] as? String ?? "Unknown"
        text = review[ReviewAttributes.text.rawValue] as? String ?? "Unknown"
        rating = review[ReviewAttributes.rating.rawValue] as? Float ?? 4.0
        
        if let time = review[ReviewAttributes.timeOfPosting.rawValue] as? Double {
            timeDescription = Date(timeIntervalSince1970: time)
        }
    }
}

