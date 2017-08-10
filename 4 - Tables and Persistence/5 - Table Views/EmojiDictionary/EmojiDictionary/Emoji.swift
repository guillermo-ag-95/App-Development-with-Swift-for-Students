//
//  Emoji.swift
//  EmojiDictionary
//
//  Created by Guillermo Alcalá Gamero on 10/8/17.
//  Copyright © 2017 Guillermo Alcalá Gamero. All rights reserved.
//

import Foundation

class Emoji {
    var symbol: String          // The actual emoji symbol.
    var name: String            // Emoji name in plain text.
    var description: String     // Describes the emoji in plain text.
    var usage: String           // Synonym in plain text.
    
    init(symbol: String, name: String, description: String, usage: String) {
        self.symbol = symbol
        self.name = name
        self.description = description
        self.usage = usage
    }
}
