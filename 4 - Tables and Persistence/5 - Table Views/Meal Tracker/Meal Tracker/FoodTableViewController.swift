//
//  FoodTableViewController.swift
//  Meal Tracker
//
//  Created by Guillermo Alcalá Gamero on 10/8/17.
//  Copyright © 2017 Guillermo Alcalá Gamero. All rights reserved.
//

import UIKit

class FoodTableViewController: UITableViewController {

    var meals: [Meal] = [
        Meal.init(name: "Breakfast", food: [
            Food.init(name: "Bread", description: "A big slice"),
            Food.init(name: "Tuna", description: "Some protein"),
            Food.init(name: "Milk", description: "GOMAD")
            ]),
        Meal.init(name: "Lunch", food: [
            Food.init(name: "Rice", description: "130 grams"),
            Food.init(name: "Steak", description: "More protein"),
            Food.init(name: "Chocolate", description: "Just a bit")
            ]),
        Meal.init(name: "Dinner", food: [
            Food.init(name: "Bread", description: "A big one"),
            Food.init(name: "Turkey", description: "And more protein"),
            Food.init(name: "Eggs", description: "DEAD")
            ])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meals[section].food.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath)
        let meal = meals[indexPath.section]
        let food = meal.food[indexPath.row]
        cell.textLabel?.text = food.name
        cell.detailTextLabel?.text = food.description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return meals[section].name
    }

}
