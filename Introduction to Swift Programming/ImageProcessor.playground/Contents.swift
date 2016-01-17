//: Playground - noun: a place where people can play

import UIKit



// Process the image!
let image = UIImage(named: "sample")
let filterNames: Array<PixelFilterType>?
let imageProcessor = ImageProcessor(image: image, withPixelFiltersNamed: filterNames)
imageProcessor.processImage()
