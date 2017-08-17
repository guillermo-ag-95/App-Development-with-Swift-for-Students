//
//  ToDoViewController.swift
//  ToDoList
//
//  Created by Guillermo Alcalá Gamero on 17/8/17.
//  Copyright © 2017 Guillermo Alcalá Gamero. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isCompletedButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    @IBOutlet weak var notesTextView: UITextView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var isPickerHidden = true
    
    /// Stores the data saved in the view.
    var todo: ToDo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let todo = todo {
            navigationItem.title = "To-Do"
            titleTextField.text = todo.title
            isCompletedButton.isSelected = todo.isComplete
            dueDatePickerView.date = todo.dueDate
            notesTextView.text = todo.notes
        } else {
            dueDatePickerView.date = Date().addingTimeInterval(60*60*24)
        }
        
        updateDueDateLabel(with: dueDatePickerView.date)
        updateSaveButtonState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // Mark: - Actions
    
    /// Updates the save button state after every change on title.
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    /// Dismiss keyboard on return.
    @IBAction func returnPressed(_ sender: UITextField) {
        titleTextField.resignFirstResponder()
    }
    
    /// Updates the check images.
    @IBAction func isCompletedTapped(_ sender: UIButton) {
        isCompletedButton.isSelected = !isCompletedButton.isSelected
    }
    
    
    
    /// Updates the due label.
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(with: dueDatePickerView.date)
    }
    // MARK: - Table view data source

    /// Set the height for each row.
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let normalCellHeight = CGFloat(44.0)
        let largeCellHeight = CGFloat(200.0)
        
        switch (indexPath.section, indexPath.row) {
        case (0,1): // Due Date Cell
            return isPickerHidden ? normalCellHeight : largeCellHeight
        case (1,0): // Notes Cell
            return largeCellHeight
        default:
            return normalCellHeight
        }
    }
    
    /// Make changes when selecting a specific row.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0,1): //
            isPickerHidden = !isPickerHidden
            tableView.deselectRow(at: indexPath, animated: true)
            dueDateLabel.textColor = isPickerHidden ? UIColor.black : tableView.tintColor
            tableView.beginUpdates()
            tableView.endUpdates()
        default:
            break
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /// Prepares everything before the segue happens.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveUnwind" else { return }
        
        let title = titleTextField.text!
        let isCompleted = isCompletedButton.isSelected
        let dueDate = dueDatePickerView.date
        let notes = notesTextView.text
        
        todo = ToDo(title: title, isComplete: isCompleted, dueDate: dueDate, notes: notes)
    }

    // MARK: - Helpers
    
    /// Disable the save button if there is no title.
    func updateSaveButtonState() {
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    /// Update the due date label to match the date from the date picker.
    /// - parameter date: The actual date from the data picker.
    func updateDueDateLabel(with date: Date) {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }
}
