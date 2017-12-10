//
//  SignInViewController.swift
//  tripPlanner
//
//  Created by Andrew Tsukuda on 11/18/17.
//  Copyright © 2017 Andrew Tsukuda. All rights reserved.
//

import UIKit
import KeychainSwift
import IHKeyboardAvoiding

class SignInViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Make Navigation Bar Clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        /* Make UI move to fit keyboard */
        KeyboardAvoiding.avoidingView = self.view
        
        /* Create sychronizable keychain instance */
        let keychain = KeychainSwift()
        keychain.synchronizable = true
        
        /* Uncomment to reset keychain */
        keychain.clear()
        
        /* Check if the userrs credentials are store in keychain */
        if keychain.get("username") != nil && keychain.get("password") != nil {
            /* If the users credentials are stored, load the trips page instead */
            loadTripsView()
        }
    }

    @IBAction func signInClicked(_ sender: Any) {
        if let username = usernameTextField.text, let password = passwordTextField.text {
            
            /* Store login info to keychain */
            let keychain = KeychainSwift()
            keychain.set(username, forKey: "username")
            keychain.set(password, forKey: "password")
            
            /* Then Load trips view */
            loadTripsView()
            
        }
    }
    
    func loadTripsView() {
        /* Load Trips Screen */
        let window = UIApplication.shared.delegate!.window!
        
        window?.rootViewController = UIStoryboard(
            name: "Main",
            bundle: Bundle.main
            ).instantiateViewController(withIdentifier: "tripsNavigationController")
        
        window?.makeKeyAndVisible()
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
