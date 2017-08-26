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
    
    @IBOutlet weak var loginInfo: CustomizableLabel!
    @IBOutlet weak var passwordInfo: CustomizableLabel!
    @IBOutlet weak var phoneInfo: CustomizableLabel!
    @IBOutlet weak var repeatPasswordError: CustomizableLabel!
    @IBOutlet weak var userExistsLabel: CustomizableLabel!
    @IBOutlet weak var emptyFieldsLabel: CustomizableLabel!
    
    @IBOutlet weak var scroll: CustomizableScrollView!
    @IBOutlet weak var scrollBottomPin: NSLayoutConstraint!
    
    let validateInput = ValidateInput.shared
    private var database = UserCoreData()
    
    @IBAction func importButtonTap(_ sender: UIButton) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
    }
    
    @IBAction func showLabelWithInfo(_ sender: UIButton) {
        let label = getLabelByTag(sender.tag)
        UIView.animate(withDuration: 0.3) {
            label.alpha = 1
        }
    }
    
    @IBAction func hideLabelWithInfo(_ sender: UIButton) {
        let label = getLabelByTag(sender.tag)
        UIView.animate(withDuration: 0.2) {
            label.alpha = 0
        }
    }
    
    @IBAction func singupButtonTap(_ sender: Any) {
        var canSignUp = true
        
        if let loginStr = login.text, let passwordStr = password.text, let passwordRepeatStr = passwordRepeat.text, let nameStr = name.text, let surnameStr = surname.text, let telStr = tel.text, let image = imageView.image {
            if passwordRepeatStr != passwordStr {
                animatedLabelShow(label: repeatPasswordError)
                canSignUp = false
            }
            if let _ = validateInput.emailExistsInDatabase(testStr: loginStr) {
                animatedLabelShow(label: userExistsLabel)
                canSignUp = false
            }
            if validateInput.isValidEmail(testStr: loginStr) == false {
                animatedLabelShow(label: loginInfo)
                canSignUp = false
            }
            if validateInput.isValidPassword(testStr: passwordStr) == false {
                animatedLabelShow(label: passwordInfo)
                canSignUp = false
            }
            if validateInput.isValidPhoneNumper(testStr: telStr) == false {
                animatedLabelShow(label: phoneInfo)
                canSignUp = false
            }
            guard let imageData = UIImageJPEGRepresentation(image, 1) else {
                print("JPEG error")
                canSignUp = false
                return
            }
            if nameStr == "" || surnameStr == "" {
                animatedLabelShow(label: emptyFieldsLabel)
            }
            if canSignUp {
                let user = User.init(name: nameStr, surname: surnameStr, email: loginStr, password: passwordStr, image: imageData as NSData, instanceToChange: .none)
                database.addUser(user: user)
                //UserDefaults.standard.set(user, forKey: "user")
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        login.delegate = self
        password.delegate = self
        passwordRepeat.delegate = self
        name.delegate = self
        surname.delegate = self
        tel.delegate = self
        repeatPasswordError.alpha = 0
        loginInfo.alpha = 0
        passwordInfo.alpha = 0
        phoneInfo.alpha = 0
        userExistsLabel.alpha = 0
        emptyFieldsLabel.alpha = 0
        
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
    
    func animatedLabelShow(label:UILabel) {
        UIView.animate(withDuration: 0.5, animations: {
            label.alpha = 1
        }, completion: { (true) in
            UIView.animate(withDuration: 0.2, delay: 2, animations: {
                label.alpha = 0
            })
        })

    }
    
    func getLabelByTag(_ tag: Int) -> UILabel {
        switch tag {
        case 0: return loginInfo
        case 1: return passwordInfo
        case 2: return phoneInfo
        default: return UILabel()
        }
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
