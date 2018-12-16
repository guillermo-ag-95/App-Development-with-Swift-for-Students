//
//  ViewController.swift
//  Light
//
//  Created by Guillermo Alcalá Gamero on 16/12/2018.
//  Copyright © 2018 Guillermo Alcalá Gamero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var isLightOn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        updateUI()
    }

    @IBAction func buttonPressed(_ sender: Any) {
        isLightOn = !isLightOn
        updateUI()
    }
    
    func updateUI(){
        view.backgroundColor = isLightOn ? .white : .black
    }
    
}

