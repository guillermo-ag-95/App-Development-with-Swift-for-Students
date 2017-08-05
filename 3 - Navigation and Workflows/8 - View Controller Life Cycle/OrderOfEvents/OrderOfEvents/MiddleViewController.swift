//
//  MiddleViewController.swift
//  OrderOfEvents
//
//  Created by Guillermo Alcalá Gamero on 5/8/17.
//  Copyright © 2017 Guillermo Alcalá Gamero. All rights reserved.
//

import UIKit

class MiddleViewController: UIViewController {

    @IBOutlet weak var lifeCycleLabel: UILabel!
    
    var eventNumber: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLifeCycleLabel(currentState: "viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLifeCycleLabel(currentState: "viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateLifeCycleLabel(currentState: "viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        updateLifeCycleLabel(currentState: "viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        updateLifeCycleLabel(currentState: "viewDidDisappear")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateLifeCycleLabel(currentState: String) {
        guard let existingText = lifeCycleLabel.text else { return }
        lifeCycleLabel.text = "\(existingText)\nEventNumber \(eventNumber) was \(currentState)"
        eventNumber += 1
    }

}
