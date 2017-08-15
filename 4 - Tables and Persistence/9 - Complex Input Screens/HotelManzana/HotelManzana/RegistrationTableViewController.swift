//
//  RegistrationTableViewController.swift
//  HotelManzana
//
//  Created by Guillermo Alcalá Gamero on 15/8/17.
//  Copyright © 2017 Guillermo Alcalá Gamero. All rights reserved.
//

import UIKit

class RegistrationTableViewController: UITableViewController {

    var registrations: [Registration] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registrations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationCell", for: indexPath)
        let registration = registrations[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none

        // Configure the cell...
        cell.textLabel?.text = "\(registration.firstName) \(registration.lastName)"
        cell.detailTextLabel?.text = "\(dateFormatter.string(from: registration.checkinDate)) - \(dateFormatter.string(from: registration.checkoutDate)): \(registration.roomType.name)"

        return cell
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
    
    @IBAction func unwindFromAddRegistration(unwindSegue: UIStoryboardSegue){
        guard
            let addRegistrationTableViewController = unwindSegue.source as? AddRegistrationTableViewController,
            let registration = addRegistrationTableViewController.registration
        else { return }
        
        registrations.append(registration)
        tableView.reloadData()
    }

}
