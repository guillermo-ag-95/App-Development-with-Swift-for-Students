//
//  ToDo.swift
//  ToDoList
//
//  Created by Guillermo Alcalá Gamero on 17/8/17.
//  Copyright © 2017 Guillermo Alcalá Gamero. All rights reserved.
//

import Foundation

class ToDo: NSObject, NSCoding {
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    /// DateFormatter available during the app lifetime.
    // Remember to add a () at the end of the "= { ... }"
    static let dueDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    init(title: String, isComplete: Bool, dueDate: Date, notes: String?) {
        guard !title.isEmpty else { fatalError("Reminder requires a non-empty title") }
        
        self.title = title
        self.isComplete = isComplete
        self.dueDate = dueDate
        self.notes = notes
    }
    
    // MARK: - NSCoding
    
    static var DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("todos")
    
    struct PropertyKeys {
        static let title = "title"
        static let isComplete = "isComplete"
        static let dueDate = "dueDate"
        static let notes = "notes"
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard
            let title = aDecoder.decodeObject(forKey: PropertyKeys.title) as? String,
            let dueDate = aDecoder.decodeObject(forKey: PropertyKeys.dueDate) as? Date,
            let isComplete = aDecoder.decodeObject(forKey: PropertyKeys.isComplete) as? Bool
        else { return nil }
        
        let notes = aDecoder.decodeObject(forKey: PropertyKeys.notes) as? String
        
        self.init(title: title, isComplete: isComplete, dueDate: dueDate, notes: notes)
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: PropertyKeys.title)
        aCoder.encode(isComplete, forKey: PropertyKeys.isComplete)
        aCoder.encode(dueDate, forKey: PropertyKeys.dueDate)
        aCoder.encode(notes, forKey: PropertyKeys.notes)
    }
    
    static func loadToDos() -> [ToDo]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: ToDo.ArchiveURL.path) as? [ToDo]
    }
    
    static func loadSampleToDos() -> [ToDo] {
        let todo1 = ToDo(title: "ToDo One", isComplete: false, dueDate: Date(), notes: "Notes 1")
        let todo2 = ToDo(title: "ToDo Two", isComplete: false, dueDate: Date(), notes: "Notes 2")
        let todo3 = ToDo(title: "ToDo Three", isComplete: false, dueDate: Date(), notes: "Notes 3")
        return [todo1, todo2, todo3]
    }
    
    static func saveToDos(_ todos: [ToDo]) {
        NSKeyedArchiver.archiveRootObject(todos, toFile: ToDo.ArchiveURL.path)
    }
}
