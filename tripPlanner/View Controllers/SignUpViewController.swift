//
//  SignUpViewController.swift
//  tripPlanner
//
//  Created by Andrew Tsukuda on 11/19/17.
//  Copyright © 2017 Andrew Tsukuda. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var usernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /* Move view up when typing */
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        /* Make Profile Image Viewer Rounded */
        self.profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        self.profileImageView.clipsToBounds = true
        // TODO: Make it work with landscape images as well

    }
    
    @IBAction func signUpButton(_ sender: Any) {
        let name = fullNameTextField.text!
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        let homeLocation = "No input Field yet, sorry"
        if password == confirmPasswordTextField.text! {
            print("Making POST request to upload user")
            let newUser = User(username: username, name: name, homeLocation: homeLocation, password: password)
            let network = Networking()
            network.addUser(resource: .users, newUser: newUser, completion: { (resp) in
                if let response = resp as? HTTPURLResponse {
                    print(response.statusCode)
                }
            })
        } else {
            print("Alert the user that their passwords do not match")
        }
        
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }

    @IBAction func setProfileImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        
        self.present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        DispatchQueue.main.async {
            let url = info["UIImagePickerControllerImageURL"] as! URL
            self.profileImageView.kf.setImage(with: url)
        }
        picker.dismiss(animated: true)
        
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
