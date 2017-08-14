//
//  FeedbacksViewController.swift
//  iTourist
//
//  Created by Zhanna Moskaliuk on 8/14/17.
//  Copyright © 2017 Lv-249iOS. All rights reserved.
//

import UIKit

class FeedbacksViewController: UIViewController {
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.isNavigationBarHidden = false
        let backgroundImage = UIImage(named: "background.png")
        let imageView = UIImageView(image: backgroundImage)
        
//        self.tableView.backgroundView = imageView
    }

    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
