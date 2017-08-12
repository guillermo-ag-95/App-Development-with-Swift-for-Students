
import UIKit

class BookTableViewController: UITableViewController {
    
    struct PropertyKeys {
        static let bookCell = "BookCell"
        static let addBookSegue = "AddBook"
        static let editBookSegue = "EditBook"
    }
    
    var books: [Book] = []
    
    var bookArchiveURL: URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsURL.appendingPathComponent("books")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBooksFromFile()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.bookCell, for: indexPath) as! BookTableViewCell
        
        let book = books[indexPath.row]
        cell.update(with: book)
        
        return cell
    }

    // MARK: - Archiving and Unarchiving
    
    func saveBooksToFile() {
        NSKeyedArchiver.archiveRootObject(books, toFile: bookArchiveURL.path)
    }
    
    func loadBooksFromFile() {
        guard let books = NSKeyedUnarchiver.unarchiveObject(withFile: bookArchiveURL.path) as? [Book] else {return}
        self.books = books
    }
    
    // MARK: - Navigation
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        guard let source = segue.source as? BookFormTableViewController,
            let book = source.book else {return}
        
        if let indexPath = tableView.indexPathForSelectedRow {
            books.remove(at: indexPath.row)
            books.insert(book, at: indexPath.row)
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            books.append(book)
        }
        
        saveBooksToFile()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let bookFormViewController = segue.destination as? BookFormTableViewController else {return}
        
        if let indexPath = tableView.indexPathForSelectedRow,
            segue.identifier == PropertyKeys.editBookSegue {
            bookFormViewController.book = books[indexPath.row]
        }
    }
    
    // Mark: - Delete books
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            books.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
}
