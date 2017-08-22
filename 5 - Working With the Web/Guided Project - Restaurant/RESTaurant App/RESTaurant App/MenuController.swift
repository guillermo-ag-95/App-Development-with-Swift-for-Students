//
//  MenuController.swift
//  RESTaurant App
//
//  Created by Guillermo Alcalá Gamero on 22/8/17.
//  Copyright © 2017 Guillermo Alcalá Gamero. All rights reserved.
//

import Foundation
import UIKit

class MenuController {
    // This instance is used in all controller.
    // No more "one controller, one instance".
    static let shared = MenuController()
    
    let baseURL = URL(string: "http://localhost:8090/")!
    
    /// A GET request to this endpoint will return an array of strings of the categories in menu.json. The array will be available under the key, "categories," in the JSON.
    func fetchCategories(completion: @escaping ([String]?) -> Void) {
        let categoryURL = baseURL.appendingPathComponent("categories")
        
        let task = URLSession.shared.dataTask(with: categoryURL) { (data, response, error) in
            if let data = data, let jsonDictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any], let categories = jsonDictionary?["categories"] as? [String] {
                completion(categories)
            } else {
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    /// A GET request to this endpoint will return the full array of menu items, but it can also be combined with the query parameter, category, to return a subset of items. The array will be available under the key, "items," with the JSON.
    func fetchMenuItems(categoryName: String, completion: @escaping ([MenuItem]?) -> Void) {
        let initialMenuURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuURL = components.url!
        
        let task = URLSession.shared.dataTask(with: menuURL) { (data, response, error) in
            if let data = data, let jsonDictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any], let menuArray = jsonDictionary?["items"] as? [[String: Any]] {
                let menuItems = menuArray.flatMap { MenuItem(json: $0) }
                completion(menuItems)
            } else {
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    /// A POST to this endpoint with the collection of menu item id values will submit the order and will return a response with the estimated time before the order will be ready. The IDs you send need to be be contained with JSON data under the key, menuIds. When you parse the JSON, an estimate of the time before the order is ready will be under the key, "preparation_time."
    func fetchSubmitOrder(menuIds: [Int], completion: @escaping (Int?) -> Void) {
        let orderURL = baseURL.appendingPathComponent("order")
        
        // Modify from GET to POST
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        
        // Telling the server that the data will be a JSON
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Store the array of menu IDs in JSON under the key "menuIds"
        let data: [String: Any] = ["menuIds": menuIds]
        let jsonData = try! JSONSerialization.data(withJSONObject: data, options: [])
        
        // Store the data within the body of the request.
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data, let jsonDictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any], let prepTime = jsonDictionary?["preparation_time"] as? Int {
                completion(prepTime)
            } else {
                completion(nil)
            }
        }
        
        task.resume()
        
    }
    
    /// You'll request that image whenever the cell is about to be displayed. At the same time, you'll check the URL cache to see if it's already retrieved the image. If it has, you can skip the network request entirely and fetch the image from memory; otherwise, you'll continue with the request to retrieve the image data.”
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        
        task.resume()
    }
    
}
