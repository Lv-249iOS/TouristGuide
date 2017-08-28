//
//  SignUpViewController.swift
//  iTourist
//
//  Created by Yaroslav Luchyt on 8/14/17.
//  Copyright © 2017 Lv-249iOS. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var surname: UILabel!
    @IBOutlet weak var tel: UILabel!
    
    private var database = UserCoreData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let email = UserDefaults.standard.getEmail()
        let currentUser = database.getUser(by: email)
        name.text = currentUser?.name
        surname.text = currentUser?.surname
        tel.text = currentUser?.phone
        if let imageNSData = currentUser?.image {
            guard let image = UIImage.init(data: imageNSData as Data) else {return}
            userImage.image = image
        }

        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(ProfileViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        let logOutButton = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(ProfileViewController.logout(sender:)))
        self.navigationItem.rightBarButtonItem = logOutButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    //back button leads to main menu
    func back(sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DashboardController")
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    func logout(sender: UIBarButtonItem) {
        UserDefaults.standard.setIsLoggedIn(value: false)
        UserDefaults.standard.setEmail(value: "")
        let storyboard = UIStoryboard(name: "LogIn", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LogInViewController")
        self.navigationController!.pushViewController(vc, animated: true)
    }
}
