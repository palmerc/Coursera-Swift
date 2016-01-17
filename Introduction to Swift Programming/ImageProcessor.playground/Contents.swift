//: Playground - noun: a place where people can play

import UIKit



// Process the image!
let image = UIImage(named: "sample")
let filterNames = ["Invert", "Grayscale"]
let imageProcessor = ImageProcessor(image: image, withPixelFilterNames: filterNames)
imageProcessor.processImage()
