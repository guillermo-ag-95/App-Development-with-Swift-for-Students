//: [Previous](@previous)

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)

let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY")!
print(url.scheme!)
print(url.host!)
print(url.query as Any)

let task = URLSession.shared.dataTask(with: url) { (data, responde, error) in
    if let data = data, let string = String(data: data, encoding: .utf8) {
        print(string)
    }
}

task.resume()

//: [Next](@next)
