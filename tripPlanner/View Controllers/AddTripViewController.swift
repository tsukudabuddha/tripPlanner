//
//  AddTripViewController.swift
//  tripPlanner
//
//  Created by Andrew Tsukuda on 12/13/17.
//  Copyright © 2017 Andrew Tsukuda. All rights reserved.
//

import UIKit

class AddTripViewController: UIViewController {
    
    var searchController: UISearchController?
    var resultView: UITextView?

    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let search = textField.text
        
    }
    
    @IBAction func panGestureRecognizer(_ sender: UIScreenEdgePanGestureRecognizer) {
        
        if sender.state == .began || sender.state == .changed {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

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
