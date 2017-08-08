//
//  Athlete.swift
//  FavoriteAthlete
//
//  Created by Guillermo Alcalá Gamero on 8/8/17.
//
//

import Foundation

struct Athlete {
    var name: String
    var age: String
    var league: String
    var team: String
    
    var description: String {
        return "\(name) is \(age) years old and play for the \(team) in the \(league)"
    }
}
