//
//  Game.swift
//  Apple Pie
//
//  Created by Guillermo Alcalá Gamero on 29/7/17.
//  Copyright © 2017 Guillermo Alcalá Gamero. All rights reserved.
//

import Foundation

struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetter: [Character]
    var formattedWord: String {
        var guessedWord: String = ""
        for letter in word.characters {
            if guessedLetter.contains(letter) {
                guessedWord += "\(letter)"
            } else {
                guessedWord += "_"
            }
        }
        return guessedWord
    }
    
    mutating func playerGuessed(character: Character) {
        guessedLetter.append(character)
        if !word.characters.contains(character) {
            incorrectMovesRemaining -= 1
        }
    }
}
