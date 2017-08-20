//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.flatMap { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}

let baseURL = URL(string: "https://itunes.apple.com/search?")!

let query: [String: String] = [
    "term": "paramore",
    "media": "music",
    "entity": "song",
    "limit": "25"
]

let searchURL = baseURL.withQueries(query)!

let task = URLSession.shared.dataTask(with: searchURL) { (data, response, error) in
    if let data = data, let string = String(data: data, encoding: .utf8) {
        print(string)
    }
}

task.resume()

// PlaygroundPage.current.finishExecution()
