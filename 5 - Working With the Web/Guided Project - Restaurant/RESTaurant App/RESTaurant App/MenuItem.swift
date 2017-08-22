//
//  MenuItem.swift
//  RESTaurant App
//
//  Created by Guillermo Alcalá Gamero on 22/8/17.
//  Copyright © 2017 Guillermo Alcalá Gamero. All rights reserved.
//

import Foundation

struct MenuItem {
    var id: Int
    var name: String
    var description: String
    var price: Double
    var category: String
    var imageURL: URL
    
    struct PropertyKeys{
        static let id = "id"
        static let name = "name"
        static let description = "description"
        static let price = "price"
        static let category = "category"
        static let imageURL = "image_url"
    }
    
    init?(json: [String: Any]) {
        guard
            let id = json[PropertyKeys.id] as? Int,
            let name = json[PropertyKeys.name] as? String,
            let description = json[PropertyKeys.description] as? String,
            let price = json[PropertyKeys.price] as? Double,
            let category = json[PropertyKeys.category] as? String,
            let imageString = json[PropertyKeys.imageURL] as? String,
            let imageURL = URL(string: imageString)
        else { return nil }
        
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.category = category
        self.imageURL = imageURL
    }
}
