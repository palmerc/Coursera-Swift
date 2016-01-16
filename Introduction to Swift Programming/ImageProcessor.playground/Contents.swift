//: Playground - noun: a place where people can play

import UIKit

let image = UIImage(named: "sample")

protocol MinMaxType {
    static var min: Self { get }
    static var max: Self { get }
}

extension UInt8 : MinMaxType {}

func gammaCorrectionFilter() -> ((Pixel) -> (Pixel))
{
    var gamma: Double = 0.25

    func filter(var pixel: Pixel) -> (Pixel)
    {
        let red = 255 * pow(Double(pixel.red) / 255, gamma)
        let green = 255 * pow(Double(pixel.green) / 255, gamma)
        let blue = 255 * pow(Double(pixel.blue) / 255, gamma)

        pixel.red = clampValue(Int(red), toRange: 0...255)!
        pixel.green = clampValue(Int(green), toRange: 0...255)!
        pixel.blue = clampValue(Int(blue), toRange: 0...255)!

        return pixel
    }

    func clampValue(value: Int, toRange range: Range<Int>) -> UInt8?
    {
        var clampedValue: UInt8?
        if value < range.minElement() {
            clampedValue = UInt8(range.minElement()!)
        } else if value > range.maxElement() {
            clampedValue = UInt8(range.maxElement()!)
        } else {
            clampedValue = UInt8(value)
        }

        return clampedValue
    }
    
    return filter
}

func brightnessPixelFilter() -> ((Pixel) -> (Pixel))
{
    var brightness: Int = 100

    func filter(var pixel: Pixel) -> (Pixel)
    {
        let red = Int(pixel.red) + brightness
        let green = Int(pixel.green) + brightness
        let blue = Int(pixel.blue) + brightness

        pixel.red = clampValue(red, toRange: 0...255)!
        pixel.green = clampValue(green, toRange: 0...255)!
        pixel.blue = clampValue(blue, toRange: 0...255)!

        return pixel
    }

    func clampValue(value: Int, toRange range: Range<Int>) -> UInt8?
    {
        var clampedValue: UInt8?
        if value < range.minElement() {
            clampedValue = UInt8(range.minElement()!)
        } else if value > range.maxElement() {
            clampedValue = UInt8(range.maxElement()!)
        } else {
            clampedValue = UInt8(value)
        }

        return clampedValue
    }

    return filter
}

func contrastPixelFilter() -> ((Pixel) -> (Pixel))
{
    var contrast: Int = 10
    var factor: Double {
        get {
            return Double(259 * (contrast + 255)) / Double(255 * (259 - contrast))
        }
    }
    func filter(var pixel: Pixel) -> (Pixel)
    {
        let red = factor * (Double(pixel.red) - 128) + 128
        let green = factor * (Double(pixel.green) - 128) + 128
        let blue = factor * (Double(pixel.blue) - 128) + 128

        let filteredRed = clampValue(Int(red), toRange: 0...255)
        let filteredGreen = clampValue(Int(green), toRange: 0...255)
        let filteredBlue = clampValue(Int(blue), toRange: 0...255)

        pixel.red = filteredRed!
        pixel.green = filteredGreen!
        pixel.blue = filteredBlue!

        return pixel
    }

    func clampValue(value: Int, toRange range: Range<Int>) -> UInt8?
    {
        var clampedValue: UInt8?
        if value < range.minElement() {
            clampedValue = UInt8(range.minElement()!)
        } else if value > range.maxElement() {
            clampedValue = UInt8(range.maxElement()!)
        } else {
            clampedValue = UInt8(value)
        }

        return clampedValue
    }

    return filter

}

func invertPixelFilter() -> ((Pixel) -> (Pixel))
{
    func filter(var pixel: Pixel) -> (Pixel)
    {
        let red = 255 - pixel.red
        let green = 255 - pixel.green
        let blue = 255 - pixel.blue
        pixel.red = red
        pixel.green = green
        pixel.blue = blue

        return pixel
    }

    return filter
}

func grayscalePixelFilter() -> ((Pixel) -> (Pixel))
{
    func filter(var pixel: Pixel) -> (Pixel)
    {
        let red = 0.2989 * Double(pixel.red)
        let green = 0.5870 * Double(pixel.green)
        let blue = 0.1140 * Double(pixel.blue)
        let grayscaleIntensity = UInt8(red + green + blue)
        pixel.red = grayscaleIntensity
        pixel.green = grayscaleIntensity
        pixel.blue = grayscaleIntensity

        return pixel
    }

    return filter
}

// Process the image!
let pixelFilter = gammaCorrectionFilter()
var mutableImage = RGBAImage(image: image!)
for y in 0..<mutableImage!.height {
    for x in 0..<mutableImage!.width {
        let index = y * mutableImage!.width + x
        var pixel = mutableImage?.pixels[index]
        mutableImage?.pixels[index] = pixelFilter(pixel!)
    }
}

mutableImage?.toUIImage()
