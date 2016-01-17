import Foundation
import UIKit



public class ImageProcessor
{
    var pixelFilters: Array<PixelFilter>?
    var image: UIImage?

    public init(image: UIImage?, withPixelFiltersNamed pixelFilterFiltersNamed: Array<PixelFilterType>?)
    {
        if image != nil {
            self.image = image
        }

        if pixelFilterFiltersNamed != nil {
            var pixelFilters = [PixelFilter]()
            for filterName in pixelFilterFiltersNamed! {
                let pixelFilter = PixelFilterFactory.filterByName(filterName)
                if (pixelFilter != nil) {
                    pixelFilters.append(pixelFilter!)
                }
            }
            self.pixelFilters = pixelFilters
        }
    }

    public func processImage() -> UIImage?
    {
        let mutableImage = RGBAImage(image: self.image!)

        for pixelFilter in self.pixelFilters! {
            for y in 0..<mutableImage!.height {
                for x in 0..<mutableImage!.width {
                    let index = y * mutableImage!.width + x
                    let pixel = mutableImage?.pixels[index]
                    let filter = pixelFilter.filter()
                    mutableImage?.pixels[index] = filter(pixel!)
                }
            }
        }

        return mutableImage?.toUIImage()
    }
}