//: Playground - noun: a place where people can play

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
UIView.animate(withDuration: 3.0, animations: { 
    square.backgroundColor = UIColor.orange
    square.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
    square.center = liveView.center
}) { (_) in
    UIView.animate(withDuration: 3.0, animations: { 
        square.backgroundColor = UIColor.purple
        square.frame = smallFrame
    })
}