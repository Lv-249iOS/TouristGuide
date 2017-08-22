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
    
    let validateInput = ValidateInput.shared
    private var database = UserCoreData()
    
    @IBAction func importButtonTap(_ sender: UIButton) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
    }
    
    @IBAction func singupButtonTap(_ sender: Any) {
        if let loginStr = login.text, let passwordStr = password.text, let passwordRepeatStr = passwordRepeat.text, let nameStr = name.text, let surnameStr = surname.text, let telStr = tel.text, let image = imageView.image {
            if passwordRepeatStr != passwordStr {
                throwAlert(title: "Error", message: "Password mismatch")
                return
            }
            if let _ = validateInput.emailExistsInDatabase(testStr: loginStr) {
                //throwAlert(title: "Error", message: "User with such login already exists")
                return
            }
            if validateInput.isValidEmail(testStr: loginStr) == false {
                //throwAlert(title: "Error", message: "Login must be email address")
                return
            }
            if validateInput.isValidPassword(testStr: passwordStr) == false {
                //throwAlert(title: "Error", message: "Password must be longer than 6 symbols")
                return
            }
            if validateInput.isValidPhoneNumper(testStr: telStr) == false {
                //throwAlert(title: "Error", message: "Phone number must be in format: XXX-XXX-XXXX")
                return
            }
            guard let imageData = UIImageJPEGRepresentation(image, 1) else {
                print("JPEG error")
                return
            }
            let user = User.init(name: nameStr, surname: surnameStr, email: loginStr, password: passwordStr, image: imageData as NSData, instanceToChange: .none)
            database.addUser(user: user)
            //UserDefaults.standard.set(user, forKey: "user")
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
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
    
    func throwAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
