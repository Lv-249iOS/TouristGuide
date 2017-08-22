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
    
    @IBAction func loginButtonTap(_ sender: UIButton) {
        //UserDefaults.standard.set(loginField.text, forKey: "userName")
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }

        
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
