//
//  Registration.swift
//  HotelManzana
//
//  Created by Guillermo Alcalá Gamero on 15/8/17.
//  Copyright © 2017 Guillermo Alcalá Gamero. All rights reserved.
//

import Foundation

struct Registration {
    var firstName: String
    var lastName: String
    var emailAddress: String
    
    var checkinDate: Date
    var checkoutDate: Date
    var numberOfAdults: Int
    var numberOfChildren: Int
    
    var roomType: RoomType
    var wifi: Bool
}
