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
            guard let image = UIImage.init(data: imageNSData as Data) else { return }
            userImage.image = image
        }
        
        let logOutButton = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(ProfileViewController.logout(sender:)))
        self.navigationItem.rightBarButtonItem = logOutButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func logout(sender: UIBarButtonItem) {
        UserDefaults.standard.setIsLoggedIn(value: false)
        UserDefaults.standard.setEmail(value: "")
        let loginStoryboard = UIStoryboard(name: "LogIn", bundle: nil)
        let loginVC = loginStoryboard.instantiateViewController(withIdentifier: "LogInViewController")
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = mainStoryboard.instantiateViewController(withIdentifier: "DashboardController")
        self.navigationController!.setViewControllers([mainVC, loginVC], animated: true)
    }
}
