//
//  RoomType.swift
//  HotelManzana
//
//  Created by Guillermo Alcalá Gamero on 15/8/17.
//  Copyright © 2017 Guillermo Alcalá Gamero. All rights reserved.
//

import Foundation

struct RoomType: Equatable {
    var id: Int
    var name: String
    var shortName: String
    var price: Double
    
    static var all: [RoomType] {
        return [RoomType(id: 0, name: "Two Queens", shortName: "2Q", price: 179),
                RoomType(id: 1, name: "One King", shortName: "K", price: 209),
                RoomType(id: 2, name: "Penthouse Suite", shortName: "PHS", price: 309)]
    }
}

func ==(lhs: RoomType, rhs: RoomType) -> Bool {
    return lhs.id == rhs.id
}
