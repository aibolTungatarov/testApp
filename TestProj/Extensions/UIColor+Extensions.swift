//
//  UIColor+Extensions.swift
//  TestProj
//
//  Created by Айбол on 28.09.2023.
//

import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue: UInt32 = 10_066_329
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if cString.count == 6 {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

extension UIColor {
    class var mainPurple: UIColor {
        return UIColor(hex: "#19212C")
    }
    
    class var textPurple: UIColor {
        return UIColor(hex: "#885FF8")
    }
    
    class var buttonBackground: UIColor {
        return UIColor(hex: "#232198")
    }
    
    class var statusGreen: UIColor {
        return UIColor(hex: "#00FF0A")
    }
    
    class var statusRed: UIColor {
        return UIColor(hex: "#FF0000")
    }
    
    class var buttonBackgroundGray: UIColor {
        return UIColor(hex: "#BFC5CF")
    }
    
    class var buttonBackgroundRed: UIColor {
        return UIColor(hex: "#FF6969")
    }
    
    class var skeletonGray: UIColor {
        return UIColor(hex: "#3F4956")
    }
    
    class var skeletonMainPurple: UIColor {
        return .mainPurple.withAlphaComponent(0.5)
    }
}
