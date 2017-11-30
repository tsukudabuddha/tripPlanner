//
//  TripsTableViewController.swift
//  tripPlanner
//
//  Created by Andrew Tsukuda on 11/10/17.
//  Copyright © 2017 Andrew Tsukuda. All rights reserved.
//

import UIKit
import Kingfisher

class TripsTableViewController: UITableViewController {

    let trips = [Trip(destination: "San Francisco, USA", duration: 20, landmarks: ["one", "two"], pictureId: "https://static.pexels.com/photos/7653/pexels-photo.jpeg"), Trip(destination: "Machu Picchu, Peru", duration: 20, landmarks: ["Machu", "Ivan"], pictureId: "https://static.pexels.com/photos/259967/pexels-photo-259967.jpeg"), Trip(destination: "Paris, France", duration: 40, landmarks: ["Eiffel Tower", "Street foods"], pictureId: "https://static.pexels.com/photos/604444/pexels-photo-604444.jpeg"), Trip(destination: "Chiang Mai, Thailand", duration: 50, landmarks: ["Beach", "Street foods"], pictureId: "https://static.pexels.com/photos/460376/pexels-photo-460376.jpeg"), Trip(destination: "Helsinki, Finland", duration: 50, landmarks: ["Water", "Pools"], pictureId: "https://static.pexels.com/photos/416728/pexels-photo-416728.jpeg"), Trip(destination: "Hannover, Germany", duration: 2, landmarks: ["Sandra", "Huessin"], pictureId: "https://static.pexels.com/photos/462149/pexels-photo-462149.jpeg")]
    
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
        
        cell.durationLabel.text = "Duration: \(trips[indexPath.row].duration) days"
//        cell.placesLabel.text = "\(trips[indexPath.row].landmarks.count) places"
        cell.destinationLabel.text = trips[indexPath.row].destination
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
