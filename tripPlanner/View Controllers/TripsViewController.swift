//
//  TripsViewController.swift
//  tripPlanner
//
//  Created by Andrew Tsukuda on 12/12/17.
//  Copyright © 2017 Andrew Tsukuda. All rights reserved.
//

import UIKit
import Kingfisher
import KeychainSwift

class TripsViewController: UIViewController, UITableViewDataSource, UITabBarDelegate {
    
    @IBOutlet weak var tripsTableView: UITableView!
    
    var trips = [TestData.Peru] {
        didSet {
            DispatchQueue.main.async {
                self.tripsTableView.reloadData()
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tripsTableView.rowHeight = UITableViewAutomaticDimension
        tripsTableView.estimatedRowHeight = 250
        
        // Make Navigation Bar Clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        /* Setup Refresh Controller */
        let refreshControl = UIRefreshControl()
        let title = NSLocalizedString("Pull To Refresh", comment: "Pull to refresh")
        refreshControl.attributedTitle = NSAttributedString(string: title, attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        refreshControl.addTarget(self,
                                 action: #selector(refreshOptions(sender:)),
                                 for: .valueChanged)
        tripsTableView.refreshControl = refreshControl
        
    }
    
    @objc private func refreshOptions(sender: UIRefreshControl) {
        /* Hide Navigation Bar */
        self.navigationController?.navigationBar.isHidden = true
        
        /* Refresh the tableView data */
        let keychain = KeychainSwift()
        if let username = keychain.get("username"), let password = keychain.get("password") {
            let network = Networking()
            network.getTrips(resource: .trips, username: username, password: password) { (trips) in
                self.trips = trips
                DispatchQueue.main.async {
                    sender.endRefreshing()
                }
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let keychain = KeychainSwift()
        
        if let username = keychain.get("username"), let password = keychain.get("password") {
            let network = Networking()
            network.getTrips(resource: .trips, username: username, password: password) { (trips) in
                self.trips = trips
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /* Get reference to cell */
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripCell", for: indexPath) as! TripTableViewCell
        
        cell.placesLabel.text = "\(trips[indexPath.row].landmarks.count) places"
        cell.destinationLabel.text = trips[indexPath.row].destinationCity
//        tableView.separatorStyle = .none // Remove white lines between cells
        
        if trips[indexPath.row].destinationCity.trimmingCharacters(in: .whitespaces).isEmpty {
            cell.destinationLabel.text = trips[indexPath.row].destinationCountry
        }
        
        cell.backgroundImageView.image = UIImage(named: trips[indexPath.row].pictureId)
        let urlString = trips[indexPath.row].pictureId
        
        if let url = URL(string: urlString){
            cell.backgroundImageView.kf.setImage(with: url)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 280
        } else {
            return 250
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
