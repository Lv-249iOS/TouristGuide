//
//  FeedbackTableViewController.swift
//  iTourist
//
//  Created by Zhanna Moskaliuk on 8/15/17.
//  Copyright © 2017 Lv-249iOS. All rights reserved.
//

import UIKit

class FeedbackTableViewController: UITableViewController {
    
    var reviews: [Review]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 145
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rew = reviews {
            return rew.count
        }
        
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedbackCell", for: indexPath) as? FeedbackCell else { return UITableViewCell() }
        guard let rew = reviews else { return UITableViewCell() }
        let review = rew[indexPath.row]
        
        cell.authorName.text = review.authorName
        cell.rating.text = "\(review.rating)"
        cell.feedBack.text = review.text
        cell.timeDescription.text = "\(review.timeDescription)"
        
//        cell.feedbackImage.image = #imageLiteral(resourceName: "noImage")
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
