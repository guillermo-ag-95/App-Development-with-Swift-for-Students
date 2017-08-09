import UIKit
import Foundation

class AthleteTableViewController: UITableViewController {
    
    var athletes: [Athlete] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return athletes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AthleteCell", for: indexPath)
        
        let athlete = athletes[indexPath.row]
        cell.textLabel?.text = athlete.name
        cell.detailTextLabel?.text = athlete.description
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let athleteFormViewController = segue.destination as! AthleteFormViewController
        if let indexPath = tableView.indexPathForSelectedRow,
            segue.identifier == "EditAthlete" {
            athleteFormViewController.athlete = athletes[indexPath.row]
        }
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        let athleteFormViewController = segue.source as! AthleteFormViewController
        guard let athlete = athleteFormViewController.athlete else { return }
        if let indexPath = tableView.indexPathForSelectedRow {
            athletes.remove(at: indexPath.row)
            // athletes.insert(athlete, at: indexPath.row)
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            athletes.append(athlete)
        }
    }
    
}
