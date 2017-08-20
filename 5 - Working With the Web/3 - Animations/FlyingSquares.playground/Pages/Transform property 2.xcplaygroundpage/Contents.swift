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

// Transform animation
UIView.animate(withDuration: 2.0, animations: { 
    square.backgroundColor = UIColor.orange
    let scaleTransform = CGAffineTransform(scaleX: 2, y: 2)
    let rotateTransform = CGAffineTransform(rotationAngle: .pi)
    let translateTransform = CGAffineTransform(translationX: 200, y: 200)
    let comboTransform = scaleTransform.concatenating(rotateTransform).concatenating(translateTransform)
    square.transform = comboTransform
}) { (_) in
    UIView.animate(withDuration: 2.0, animations: { 
        square.transform = CGAffineTransform.identity
    })
}

//: [Next](@next)
