//
//  SignInViewController.swift
//  tripPlanner
//
//  Created by Andrew Tsukuda on 11/18/17.
//  Copyright © 2017 Andrew Tsukuda. All rights reserved.
//

import UIKit
import KeychainSwift

protocol signInDelegate: class {
    func storeLogInInfo(username: String, password: String)
    
}

class SignInViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
//    weak var delegate: signInDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Make Navigation Bar Clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        // Move view up when typing
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        let keychain = KeychainSwift()
        keychain.synchronizable = true
        if keychain.get("username") != nil && keychain.get("password") != nil {
            /* Load trips page instead */
            let window = UIApplication.shared.delegate!.window!
            
            window?.rootViewController = UIStoryboard(
                name: "Main",
                bundle: Bundle.main
                ).instantiateViewController(withIdentifier: "tripsNavigationController")
            window?.makeKeyAndVisible()
        }
    }
    @IBAction func signInClicked(_ sender: Any) {
        if let username = usernameTextField.text, let password = passwordTextField.text {
            
            /* Store login info to keychain */
            let keychain = KeychainSwift()
            keychain.set(username, forKey: "username")
            keychain.set(password, forKey: "password")
            
            /* Load Trips Screen */
            let window = UIApplication.shared.delegate!.window!
            
            window?.rootViewController = UIStoryboard(
                name: "Main",
                bundle: Bundle.main
                ).instantiateViewController(withIdentifier: "tripsNavigationController")
            
            window?.makeKeyAndVisible()
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
