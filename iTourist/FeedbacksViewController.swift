//
//  FeedbacksViewController.swift
//  iTourist
//
//  Created by Zhanna Moskaliuk on 8/14/17.
//  Copyright © 2017 Lv-249iOS. All rights reserved.
//

import UIKit

class FeedbacksViewController: UIViewController {
    var reviews: [Review]?
    var fedbackTableViewController: FeedbackTableViewController!
    
    @IBAction func stopFeedbacks(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FeedbacksViewControllerSeque" , let controller = segue.destination as? FeedbackTableViewController {
            fedbackTableViewController = controller
            if let reviews = reviews {
                fedbackTableViewController.reviews = reviews
            }
        }
    }
    
}
