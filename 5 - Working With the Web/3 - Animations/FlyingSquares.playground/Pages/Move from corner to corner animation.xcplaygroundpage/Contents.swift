//: [Previous](@previous)

import UIKit
import PlaygroundSupport

// Main view
let liveViewFrame = CGRect(x: 0, y: 0, width: 500, height: 500)
let liveView = UIView(frame: liveViewFrame)
liveView.backgroundColor = UIColor.white
PlaygroundPage.current.liveView = liveView

// Subview
let smallFrame = CGRect(x: 0, y: 0, width: 100, height: 100)
let square = UIView(frame: smallFrame)
square.backgroundColor = UIColor.purple
liveView.addSubview(square)

// Animation
UIView.animate(withDuration: 3.0, delay: 2.0, options: [.repeat], animations: {
    square.backgroundColor = UIColor.orange
    square.frame = CGRect(x: 400, y: 400, width: 100, height: 100)
}, completion: nil)

//: [Next](@next)
