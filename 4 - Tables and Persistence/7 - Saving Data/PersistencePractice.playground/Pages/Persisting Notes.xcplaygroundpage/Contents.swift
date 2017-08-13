//: Playground - Lesson 4.7: Saving Data

import UIKit

class Note: NSObject, NSCoding {
    var title: String
    var text: String
    var timestamp: Date
    
    override var description: String {
        return "Note(title: \"\(title)\", text: \"\(text)\", timestamp: \(timestamp))"
        
    }
    
    init(title: String, text: String, timestamp: Date) {
        self.title = title
        self.text = text
        self.timestamp = timestamp
    }
    
    // Mark: - Coding
    
    struct PropertyKeys {
        static let title = "title"
        static let text = "text"
        static let timestamp = "timestamp"
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard
            let title = aDecoder.decodeObject(forKey: PropertyKeys.title) as? String,
            let text = aDecoder.decodeObject(forKey: PropertyKeys.text) as? String,
            let timestamp = aDecoder.decodeObject(forKey: PropertyKeys.timestamp) as? Date
        else { return nil }
        self.init(title: title, text: text, timestamp: timestamp)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: PropertyKeys.title)
        aCoder.encode(text, forKey: PropertyKeys.text)
        aCoder.encode(timestamp, forKey: PropertyKeys.timestamp)
    }
}

let note: Note = Note(title: "A New Hope", text: "We have the plans.", timestamp: Date())
let archivedNote = NSKeyedArchiver.archivedData(withRootObject: note)
let unarchivedNote = NSKeyedUnarchiver.unarchiveObject(with: archivedNote) as? Note

let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
let archiveURL = documentsDirectory.appendingPathComponent("notes")

let secondNote = Note(title: "Luke", text: "I'm your father", timestamp: Date())
let secondArchivedNote = NSKeyedArchiver.archiveRootObject(secondNote, toFile: archiveURL.path)
let secondUnarchiveNote = NSKeyedUnarchiver.unarchiveObject(withFile: archiveURL.path) as? Note

let note1 = Note(title: "Note One", text: "This is a sample note.", timestamp: Date())
let note2 = Note(title: "Note Two", text: "This is anothersample note.", timestamp: Date())
let note3 = Note(title: "Note Three", text: "This is yet another sample note.", timestamp: Date())
    
let notes = [note1, note2, note3]
let archivedNotes = NSKeyedArchiver.archiveRootObject(notes, toFile: archiveURL.path)
let unarchivedNotes = NSKeyedUnarchiver.unarchiveObject(withFile: archiveURL.path) as? [Note]

print(unarchivedNotes)