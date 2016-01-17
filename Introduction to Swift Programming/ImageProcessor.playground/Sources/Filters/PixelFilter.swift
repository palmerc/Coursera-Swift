import Foundation



public enum PixelFilterType {
    case Brightness
    case Contrast
    case Gamma
    case Grayscale
    case Invert
}

public protocol PixelFilter
{
    var filterName: PixelFilterType { get }
    func filter() -> ((Pixel) -> (Pixel))
}

public class PixelFilterFactory
{
    class func filterByName(pixelFilterName: PixelFilterType) -> PixelFilter?
    {
        var pixelFilter: PixelFilter?
        switch pixelFilterName {
        case .Brightness:
            pixelFilter = BrightnessFilter()
            break
        case .Contrast:
            pixelFilter = ContrastFilter()
            break
        case .Gamma:
            pixelFilter = GammaFilter()
            break
        case .Grayscale:
            pixelFilter = GrayscaleFilter()
            break
        case .Invert:
            pixelFilter = InvertFilter()
            break
        }

        return pixelFilter
    }
}