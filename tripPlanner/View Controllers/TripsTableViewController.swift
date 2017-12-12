//
//  TripsTableViewController.swift
//  tripPlanner
//
//  Created by Andrew Tsukuda on 11/10/17.
//  Copyright © 2017 Andrew Tsukuda. All rights reserved.
//

import UIKit
import Kingfisher
import KeychainSwift

class TripsTableViewController: UITableViewController {
    var username: String?
    var password: String? 

    var trips = [TestData.Peru] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 250
        
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
        tableView.refreshControl = refreshControl
        
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

    @IBAction func addTrip(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "addTripVC")
        if let controller = controller {
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return trips.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /* Get reference to cell */
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripCell", for: indexPath) as! TripTableViewCell
        
//        cell.durationLabel.text = "Duration: \(trips[indexPath.row].duration) days"
//        cell.placesLabel.text = "\(trips[indexPath.row].landmarks.count) places"
        cell.destinationLabel.text = trips[indexPath.row].destinationCity
//        cell.backgroundColor = UIColor.black // Remove white lines between cells
        tableView.separatorStyle = .none
    
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 280
        } else {
            return 250
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
