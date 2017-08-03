//
//  ViewController.swift
//  TrafficSegues
//
//  Created by Guillermo Alcalá Gamero on 3/8/17.
//  Copyright © 2017 Guillermo Alcalá Gamero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var segueSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func yellowButtonTapped(_ sender: UIButton) {
        guard segueSwitch.isOn else { return }
        performSegue(withIdentifier: "Yellow", sender: nil)
    }

    @IBAction func greenButtonTapped(_ sender: UIButton) {
        guard segueSwitch.isOn else { return }
        performSegue(withIdentifier: "Green", sender: nil)
    }
    
}
