//
//  ViewController.swift
//  AppEventCount
//
//  Created by Guillermo Alcalá Gamero on 8/8/17.
//  Copyright © 2017 Guillermo Alcalá Gamero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var didFinishLaunchingLabel: UILabel!
    @IBOutlet weak var willResingActiveLabel: UILabel!
    @IBOutlet weak var didEnterBackgroundLabel: UILabel!
    @IBOutlet weak var willEnterForegroundLabel: UILabel!
    @IBOutlet weak var didBecomeActiveLabel: UILabel!
    @IBOutlet weak var willTerminateLabel: UILabel!
    
    var didFinishLaunchingCount = 0
    var willResingActiveCount = 0
    var didEnterBackgroundCount = 0
    var willEnterForegroundCount = 0
    var didBecomeActiveCount = 0
    var willTerminateCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateView() {
        didFinishLaunchingLabel.text = "The app has launched \(didFinishLaunchingCount) time(s)"
        willResingActiveLabel.text = "The app has been about to leave the foreground \(willResingActiveCount) time(s)"
        didEnterBackgroundLabel.text = "The app has entered the background \(didEnterBackgroundCount) time(s)"
        willEnterForegroundLabel.text = "The app has transit from background to active state \(willEnterForegroundCount) time(s)"
        didBecomeActiveLabel.text = "The app has become active \(didBecomeActiveCount) time(s)"
        willTerminateLabel.text = "The app has been cleaned from memory \(willTerminateCount) time(s)"
    }

}

