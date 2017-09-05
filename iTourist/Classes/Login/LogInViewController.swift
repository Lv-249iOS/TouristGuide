//
//  LogInViewController.swift
//  iTourist
//
//  Created by Yaroslav Luchyt on 8/14/17.
//  Copyright © 2017 Lv-249iOS. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var scrollBottomPin: NSLayoutConstraint!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var password: UITextField!
    
    let validateInput = ValidateInput.shared
    
    @IBAction func loginButtonTap(_ sender: UIButton) {
        if let loginStr = loginField.text, let passwordStr = password.text {
            if let user = validateInput.emailExistsInDatabase(testStr: loginStr) {
                if passwordStr == user.password {
                    UserDefaults.standard.setIsLoggedIn(value: true)
                    UserDefaults.standard.setEmail(value: loginStr)
                    
                    let profileStoryboard = UIStoryboard(name: "Profile", bundle: nil)
                    let profileVC = profileStoryboard.instantiateViewController(withIdentifier: "ProfileViewController")
                    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let mainVC = mainStoryboard.instantiateViewController(withIdentifier: "DashboardController")
                    self.navigationController!.setViewControllers([mainVC, profileVC], animated: true)
                    return
                }
            }
        }
        throwAlert(title: "Error", message: "Wrong login or password")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginField.delegate = self
        self.password.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: .UIKeyboardWillHide, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func throwAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func handleKeyboardShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRekt = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRekt.height
            scrollBottomPin.constant = keyboardHeight
            UIView.animate(withDuration: 0, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func handleKeyboardHide(notification: NSNotification) {
        scrollBottomPin.constant = 0
    }
}

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginField.resignFirstResponder()
        password.resignFirstResponder()
        return true
    }
}
