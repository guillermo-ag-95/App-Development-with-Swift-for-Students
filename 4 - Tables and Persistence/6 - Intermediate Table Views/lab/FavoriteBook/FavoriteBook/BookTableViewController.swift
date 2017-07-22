
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
        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.bookCell, for: indexPath)
        
        let book = books[indexPath.row]
        cell.textLabel?.text = book.title
        cell.detailTextLabel?.text = book.description
        
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
        guard let source = segue.source as? BookFormViewController,
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
        guard let bookFormViewController = segue.destination as? BookFormViewController else {return}
        
        if let indexPath = tableView.indexPathForSelectedRow,
            segue.identifier == PropertyKeys.editBookSegue {
            bookFormViewController.book = books[indexPath.row]
        }
    }
    
}
