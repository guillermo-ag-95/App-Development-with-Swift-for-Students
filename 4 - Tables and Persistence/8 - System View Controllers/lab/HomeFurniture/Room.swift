
import Foundation

class Room {
    var name: String
    var furniture: [Furniture]
    
    init(name: String, furniture: [Furniture]) {
        self.name = name
        self.furniture = furniture
    }
}
