//
//  AthleteFormViewController.swift
//  FavoriteAthlete
//
//  Created by Guillermo Alcalá Gamero on 8/8/17.
//
//

import UIKit

class AthleteFormViewController: UIViewController {

    var athlete: Athlete?
    
    @IBOutlet weak var athleteNameTextField: UITextField!
    @IBOutlet weak var athleteAgeTextField: UITextField!
    @IBOutlet weak var athleteLeagueTextField: UITextField!
    @IBOutlet weak var athleteTeamTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveAthlete(_ sender: UIButton) {
        guard
            let name = athleteNameTextField.text,
            let age = athleteAgeTextField.text,
            let league = athleteLeagueTextField.text,
            let team = athleteTeamTextField.text
        else { return }
        athlete = Athlete(name: name, age: age, league: league, team: team)
        performSegue(withIdentifier: "saveAthlete", sender: self)
    }
    
    func updateView() {
        guard let athlete = athlete else { return }
        athleteNameTextField.text = athlete.name
        athleteAgeTextField.text = athlete.age
        athleteLeagueTextField.text = athlete.league
        athleteTeamTextField.text = athlete.team
    }

}
