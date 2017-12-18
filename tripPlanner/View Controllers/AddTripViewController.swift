//
//  AddTripViewController.swift
//  tripPlanner
//
//  Created by Andrew Tsukuda on 12/13/17.
//  Copyright © 2017 Andrew Tsukuda. All rights reserved.
//

import UIKit
import GooglePlaces

class AddTripViewController: UIViewController {
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?

    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
//        self.searchTextField.layer.borderColor = UIColor.white.cgColor
////        self.searchTextField.layer.borderWidth = 1
//        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        
        
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
//        let whitePlaceHolderText = NSAttributedString(string: "Where would you love to travel?", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
//        searchTextField.attributedPlaceholder = whitePlaceHolderText

        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self

        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController



        // Add the search bar to the right of the nav bar,
        // use a popover to display the results.
        // Set an explicit size as we don't want to use the entire nav bar.

        searchController?.searchBar.frame = searchTextField.frame
        self.view.addSubview((searchController?.searchBar)!)

        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true

        // Keep the navigation bar visible.
        searchController?.hidesNavigationBarDuringPresentation = false
        searchController?.modalPresentationStyle = .fullScreen
        searchController?.searchBar.placeholder = "Where would you love to travel?"
        searchController?.searchBar.searchBarStyle = .minimal
        searchController?.searchBar.barTintColor = UIColor.white
        searchController?.searchBar.layer.borderColor = UIColor.white.cgColor
        searchController?.searchBar.layer.borderWidth = 2
        

        /* */
//        subview.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        searchController?.searchResultsController?.view.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10)
        
        print("Frame: \(searchController?.searchBar.frame)")

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

// Handle the user's selection.
extension AddTripViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        // Do something with the selected place.
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
