//
//  Game.swift
//  Apple Pie 2
//
//  Created by Guillermo Alcalá Gamero on 30/7/17.
//  Copyright © 2017 Guillermo Alcalá Gamero. All rights reserved.
//

import Foundation

struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character]
    var formattedWord: String {
        var guessedWord = ""
        for letter in word.characters {
            if guessedLetters.contains(letter) {
                guessedWord.append(letter)
            } else {
                guessedWord.append("_")
            }
        }
        return guessedWord
    }
    
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter)
        if !word.contains(String(letter)) {
            incorrectMovesRemaining -= 1
        }
    }
}
