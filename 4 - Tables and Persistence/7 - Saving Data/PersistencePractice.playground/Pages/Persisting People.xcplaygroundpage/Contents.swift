//: Playground - Lesson 4.7: Saving Data

import UIKit

class Person: NSObject, NSCoding {
    var name: String
    var height: String
    var weight: String
    
    override var description: String {
        return "Person(title: \"\(name)\", text: \"\(height)\", timestamp: \(weight))"
        
    }
    
    init(name: String, height: String, weight: String) {
        self.name = name
        self.height = height
        self.weight = weight
    }
    
    // Mark: - Coding
    
    struct PropertyKeys {
        static let name = "name"
        static let height = "height"
        static let weight = "weight"
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard
            let name = aDecoder.decodeObject(forKey: PropertyKeys.name) as? String,
            let height = aDecoder.decodeObject(forKey: PropertyKeys.height) as? String,
            let weight = aDecoder.decodeObject(forKey: PropertyKeys.weight) as? String
        else { return nil }
        self.init(name: name, height: height, weight: weight)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKeys.name)
        aCoder.encode(height, forKey: PropertyKeys.height)
        aCoder.encode(weight, forKey: PropertyKeys.weight)
    }
}

let person = Person(name: "Guillermo", height: "178", weight: "80")
let archivedPerson = NSKeyedArchiver.archivedData(withRootObject: person)
let unarchivedPerson = NSKeyedUnarchiver.unarchiveObject(with: archivedPerson) as? Person
