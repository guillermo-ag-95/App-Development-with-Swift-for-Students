
import UIKit

class EmployeeDetailTableViewController: UITableViewController, UITextFieldDelegate, EmployeeTypeDelegate {

    struct PropertyKeys {
        static let unwindToListIndentifier = "UnwindToListSegue"
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var dobDatePicker: UIDatePicker!
    @IBOutlet weak var employeeTypeLabel: UILabel!
    
    var isEditingDob: Bool = false {
        didSet {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    var employee: Employee?
    var employeeType: EmployeeType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        
        // Setting the maximum date possible and the one displayed.
        let midnightToday = Calendar.current.startOfDay(for: Date())
        dobDatePicker.maximumDate = midnightToday
        
        if dobLabel.text == nil {
            dobDatePicker.date = midnightToday
        } else {
            dobDatePicker.date = setDatePickerFromString(date: dobLabel.text!)
        }
        
    }
    
    func updateView() {
        if let employee = employee {
            navigationItem.title = employee.name
            nameTextField.text = employee.name
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dobLabel.text = dateFormatter.string(from: employee.dateOfBirth)
            dobLabel.textColor = .black
            employeeTypeLabel.text = employee.employeeType.description()
            employeeTypeLabel.textColor = .black
        } else {
            navigationItem.title = "New Employee"
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if
            let name = nameTextField.text,
            let employeeTypeSelected = employeeType {
            employee = Employee(name: name, dateOfBirth: dobDatePicker.date, employeeType: employeeTypeSelected)
            performSegue(withIdentifier: PropertyKeys.unwindToListIndentifier, sender: self)
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        employee = nil
        performSegue(withIdentifier: PropertyKeys.unwindToListIndentifier, sender: self)
    }
    
    @IBAction func dobDatePickerTapped(_ sender: UIDatePicker) {
        dobLabel.text = formatDate(date: sender.date)
    }
    
    // MARK: - Text Field Delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row != 2 {
            return 44.0
        } else {
            if isEditingDob {
                return 216.0
            } else {
                return 0.0
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect the actual row.
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Change the Dob editing status.
        if indexPath.row == 1 {
            isEditingDob = !isEditingDob
        }
        
        // Change label color.
        dobLabel.textColor = UIColor.black
        
        // Set the date to the label.
        dobLabel.text = formatDate(date: dobDatePicker.date)
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
    
    func setDatePickerFromString(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        let unwrappedDate = dateFormatter.date(from: date)
        guard let date = unwrappedDate else { return Date() }
        return date
    }
    
    func didSelect(employeeType: EmployeeType) {
        self.employeeType = employeeType
        employeeTypeLabel.text = employeeType.description()
        employeeTypeLabel.textColor = UIColor.black
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectEmployeeType" {
            let destinationViewController = segue.destination as? EmployeeTypeTableViewController
            destinationViewController?.delegate = self
        }
    }

}
