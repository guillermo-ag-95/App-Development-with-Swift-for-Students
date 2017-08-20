import UIKit
import PlaygroundSupport

// Part One: HTTP, URLs, and URL Session

PlaygroundPage.current.needsIndefiniteExecution = true
URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)

struct PropertyKeys {
    static let name = "trackName"
    static let description = "shortDescription"
    static let kind = "kind"
    static let sdPrice = "trackPrice"
    static let hdPrice = "trackHdPrice"
}

struct StoreItem {
    var name: String // trackName
    var description: String // description
    var kind: String // kind
    var sdPrice: Double? // trackPrice
    var hdPrice: Double? // trackHdPrice
    
    init?(json: [String: Any]) {
        guard
            let name = json[PropertyKeys.name] as? String,
            let description = json[PropertyKeys.description] as? String,
            let kind = json[PropertyKeys.kind] as? String
        else { return nil }
    
        self.name = name
        self.description = description
        self.kind = kind
        self.sdPrice = json[PropertyKeys.sdPrice] as? Double
        self.hdPrice = json[PropertyKeys.hdPrice] as? Double
    }
}

extension URL {
    
    func withQueries(_ queries: [String: String]) -> URL? {
        
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.flatMap { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}

let query: [String: String] = [
    "term": "Inside Out 2015",
    "media": "movie",
    "lang": "en_us",
    "limit": "10"
]

func fetchItems(matching query: [String: String], completion: @escaping ([StoreItem]?) -> Void) {
    let baseURL = URL(string: "https://itunes.apple.com/search?")!
    let searchURL = baseURL.withQueries(query)!
    let task = URLSession.shared.dataTask(with: searchURL) { (data, response, error) in
        if  let data = data,
            let rawJSON = try? JSONSerialization.jsonObject(with: data),
            let json = rawJSON as? [String: Any],
            let resultsArray = json["results"] as? [[String: Any]] {
            
            let storeItems = resultsArray.flatMap { StoreItem(json: $0) }
            completion(storeItems)
            
            PlaygroundPage.current.finishExecution()
        } else {
            print("Either no data was returned, or data was not serialized.")
            completion(nil)
            return
        }
    }
    
    task.resume()
    
}

fetchItems(matching: query) { (items) in
    print(items!.first!)
}
/*:
 
 _Copyright © 2017 Apple Inc._
 
 _Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:_
 
 _The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software._
 
 _THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE._
 */
