//
//  ProfileViewController.swift
//  iTourist
//
//  Created by Zhanna Moskaliuk on 8/3/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordRepeat: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var tel: UITextField!
    @IBOutlet weak var scroll: CustomizableScrollView!
    @IBOutlet weak var scrollBottomPin: NSLayoutConstraint!
    
    @IBAction func importButtonTap(_ sender: UIButton) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.login.delegate = self
        self.password.delegate = self
        self.passwordRepeat.delegate = self
        self.name.delegate = self
        self.surname.delegate = self
        self.tel.delegate = self
        
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
            scrollBottomPin.constant = -keyboardHeight
            UIView.animate(withDuration: 0, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func handleKeyboardHide(notification: NSNotification) {
        scrollBottomPin.constant = 0
    }
}

extension SignUpViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
        } else {
            let alert = UIAlertController(title: "Error", message: "Couldn't get the picture", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        login.resignFirstResponder()
        password.resignFirstResponder()
        passwordRepeat.resignFirstResponder()
        name.resignFirstResponder()
        surname.resignFirstResponder()
        tel.resignFirstResponder()
        return true
    }
}
