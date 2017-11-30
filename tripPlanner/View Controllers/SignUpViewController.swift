//
//  SignUpViewController.swift
//  tripPlanner
//
//  Created by Andrew Tsukuda on 11/19/17.
//  Copyright © 2017 Andrew Tsukuda. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /* Make Profile Image Viewer Rounded */
        self.profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        self.profileImageView.clipsToBounds = true
        // TODO: Make it work with landscape images as well

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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
