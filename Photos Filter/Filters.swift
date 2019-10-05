import UIKit

class Filters {
    
    func warm(image : RGBAImage,Cons:Double ) -> UIImage {
        var Img = image
        for y in 0 ..< Img.height
        {
            for x in 0 ..< Img.width
            {
                let px = y * Img.width + x
                Img.pixels[px].red = UInt8(max(0, min (255,Double(Img.pixels[px].red) * 1.3 * Cons)))
            }
            
        }
        let image = Img.toUIImage()
        return image!
    }
    
    func cloudy(image : RGBAImage ,Cons:Double  ) -> UIImage {
        var Img = image
        for y in 0 ..< Img.height
        {
            for x in 0 ..< Img.width
            {
                let px = y * Img.width + x
                Img.pixels[px].blue = UInt8 (max(0,min(255,Double(Img.pixels[px].blue) * 1.5 * Cons)))

            }
            
        }
        let image = Img.toUIImage()
        return image!
    }
    
    func land(image : RGBAImage ,Cons:Double  ) -> UIImage {
        var Img = image
        for y in 0 ..< Img.height
        {
            for x in 0 ..< Img.width
            {
                let px = y * Img.width + x
                Img.pixels[px].red = UInt8(max(0, min (255,Double(Img.pixels[px].red) * 1.3 * Cons)))
                Img.pixels[px].green = UInt8 (max(0,min(255,Double(Img.pixels[px].green) * 1.2 * Cons)))
                Img.pixels[px].blue = UInt8 (max(0,min(255,Double(Img.pixels[px].blue) * 1.5 * Cons)))
            }
            
        }
        let image = Img.toUIImage()
        return image!
    }
    
    func BW(image : UIImage  ) -> UIImage {
        let Img = CIImage(image:image)
        let blackImage = Img?.applyingFilter("CIColorControls", parameters: [kCIInputSaturationKey:0.0])
        return UIImage.init(ciImage:blackImage!)
    }
    
    func bright(image : RGBAImage ,Cons:Double ) -> UIImage {
        var Img = image
        for y in 0 ..< Img.height
        {
            for x in 0 ..< Img.width
            {
                let px = y * Img.width + x
                Img.pixels[px].red = UInt8(max(0, min (255,Double(Img.pixels[px].red) * 1.3 * Cons)))
                Img.pixels[px].green = UInt8 (max(0,min(255,Double(Img.pixels[px].green) * 1.4 * Cons)))
                Img.pixels[px].blue = UInt8 (max(0,min(255,Double(Img.pixels[px].blue) * 1.2 * Cons)))
            
            }
            
        }
        let image = Img.toUIImage()
        return image!
    }
     
}
