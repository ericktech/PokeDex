//
//  Extension.swift
//  PokeDex
//
//  Created by Erick Leal on 15/10/22.
//

import Foundation
import UIKit

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
            if #available(iOS 11, *) {
                var cornerMask = CACornerMask()
                if(corners.contains(.topLeft)){
                    cornerMask.insert(.layerMinXMinYCorner)
                }
                if(corners.contains(.topRight)){
                    cornerMask.insert(.layerMaxXMinYCorner)
                }
                if(corners.contains(.bottomLeft)){
                    cornerMask.insert(.layerMinXMaxYCorner)
                }
                if(corners.contains(.bottomRight)){
                    cornerMask.insert(.layerMaxXMaxYCorner)
                }
                self.layer.cornerRadius = radius
                self.layer.maskedCorners = cornerMask

            } else {
                let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
                let mask = CAShapeLayer()
                mask.path = path.cgPath
                self.layer.mask = mask
            }
        }
}

extension UIImageView {
    func loadFrom(URLAddress: String?) {
        guard let safeUrl = URLAddress else {return}
        guard let url = URL(string: safeUrl) else {
            return
        }
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    self?.image = loadedImage
                }
            }
        }
    }
}

extension UIColor{
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    class func grass() -> UIColor{
        return UIColor(rgb: 0x78C850)
    }
    
    class func fire() -> UIColor{
        return UIColor(rgb: 0xF08030)
    }
    class func water() -> UIColor{
        return UIColor(rgb: 0x6890f0)
    }
    class func bug() -> UIColor{
        return UIColor(rgb: 0xA8B820)
    }
    class func normal() -> UIColor{
        return UIColor(rgb: 0xA8A878)
    }
    class func poison() -> UIColor{
        return UIColor(rgb: 0xA040A0)
    }
    class func electric() -> UIColor{
        return UIColor(rgb: 0xF8D030)
    }
    class func ground() -> UIColor{
        return UIColor(rgb: 0xE0C068)
    }
    class func fairy() -> UIColor{
        return UIColor(rgb: 0xEE99AC)
    }
    class func figthing() -> UIColor{
        return UIColor(rgb: 0xC03028)
    }
    class func psychic() -> UIColor{
        return UIColor(rgb: 0xF85888)
    }
    class func rock() -> UIColor{
        return UIColor(rgb: 0xB8A038)
    }
    class func ghost() -> UIColor{
        return UIColor(rgb: 0x705898)
    }
    class func ice() -> UIColor{
        return UIColor(rgb: 0x98D8D8)
    }
    class func dragon() -> UIColor{
        return UIColor(rgb: 0x7038F8)
    }
    
    
    
}
