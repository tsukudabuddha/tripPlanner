//
//  SignUpViewController.swift
//  tripPlanner
//
//  Created by Andrew Tsukuda on 11/19/17.
//  Copyright © 2017 Andrew Tsukuda. All rights reserved.
//

import UIKit
import IHKeyboardAvoiding

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
        KeyboardAvoiding.avoidingView = self.view
        
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
                    let alert = UIAlertController(title: "Sorry an unknown error has occured", message: "Please try again", preferredStyle: .alert)
                    
                    switch response.statusCode {
                    case 200:
                        alert.title = "Congrats on signing up!"
                        alert.message = "Your account has been created!"
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                            /* Transition to Trips screen  */
                            DispatchQueue.main.async {
                                //                                self.performSegue(withIdentifier: "signUpToTrips", sender: self)
                                let window = UIApplication.shared.delegate!.window!
                                
                                window?.rootViewController = UIStoryboard(
                                    name: "Main",
                                    bundle: Bundle.main
                                    ).instantiateViewController(withIdentifier: "tripsNavigationController")
                                window?.makeKeyAndVisible()
                            }
                        }))
                        
                    case 409:
                        alert.title = "Sorry that username is already taken"
                        alert.message = "Try signing in?"
                        alert.addAction(UIAlertAction(title: "Sign In", style: .default, handler: { (action) in
                            /* Transition to Sign in Screen  */
                            }))
                            
                    default:
                        print("Resort to default alert(?)")
                    }
                    self.showAlert(alert: alert)
                    
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
    
    func showAlert(alert: UIAlertController) {
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
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
