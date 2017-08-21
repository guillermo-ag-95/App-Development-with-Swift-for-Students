//
//  PhotoInfoController.swift
//  SpacePhoto
//
//  Created by Guillermo Alcalá Gamero on 21/8/17.
//  Copyright © 2017 Guillermo Alcalá Gamero. All rights reserved.
//

import Foundation

struct PhotoInfoController {
    
    func fetchPhotoInfo(completion: @escaping (PhotoInfo?) -> Void) {
        let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!
        
        let query: [String: String] = [
            "api_key": "DEMO_KEY",
            ]
        
        let url = baseURL.withQueries(query)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let rawJSON = try? JSONSerialization.jsonObject(with: data), let json = rawJSON as? [String: String], let photoInfo = PhotoInfo(json: json) {
                completion(photoInfo)
            } else {
                print("Either no data was returned, or data was not serialized.")
                print("Error: \(String(describing: error))")
                completion(nil)
            }
        }
        task.resume()
    }
}
