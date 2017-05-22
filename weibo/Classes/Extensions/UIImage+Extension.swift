//
//  UIImage+Extension.swift
//  weibo
//
//  Created by Allan-Dev1 on 2017-05-13.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

extension UIImage {
     
    
    /// create circle image
    ///
    /// - Parameters:
    ///   - size: size of image
    ///   - backColor: make the corner match the background color
    ///   - borderColor: border color
    ///   - hasBorder: set border or not
    /// - Returns: UIImage
    func roundedImage(size: CGSize?, backColor: UIColor = UIColor.white, borderColor: UIColor = UIColor.lightGray, hasBorder: Bool = true) -> UIImage? {
        
        var size = size
        if size == nil {
            size = self.size
        }
        
        let rect = CGRect(origin: CGPoint(), size: size!)
        
        UIGraphicsBeginImageContextWithOptions(size!, true, 0)
        
        backColor.setFill()
        UIRectFill(rect)
        
        let path = UIBezierPath(ovalIn: rect)
        path.addClip()
        
        draw(in: rect)
        
        if hasBorder {
            let borderPath = UIBezierPath(ovalIn: rect)
            borderPath.lineWidth = 2
            borderColor.setStroke()
            borderPath.stroke()
        }
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return result
        
        
    }
    
 
    
    /// Resize image for better memory performance
    ///
    /// - Parameter size: new size of the image
    /// - Parameter backColor: background color of the image
    /// - Parameter isTransparent: whether image has transparent background (like png)
    //                             if yes, need to set the background color match superview's background
    /// - Returns: UIImage
    func image(size: CGSize? = nil, backColor: UIColor = UIColor.white, isTransparent: Bool = true) -> UIImage? {
        
        var size = size
        if size == nil {
            size = self.size
        }
        let rect = CGRect(origin: CGPoint(), size: size!)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        
        if isTransparent {
            backColor.setFill()
            UIRectFill(rect)
        }
        
        draw(in: rect)
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return result
    }
    
// 
//    /// Resize image for better memory performance (for non transparent image, like JPG)
//    ///
//    /// - Parameter size: new size of the image
//    /// - Returns: UIImage
//    func resizeImage(size: CGSize? = nil) -> UIImage? {
//        
//        var size = size
//        if size == nil {
//            size = self.size
//        }
//        let rect = CGRect(origin: CGPoint(), size: size!)
//        
//        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
//      
//        draw(in: rect)
//        
//        let result = UIGraphicsGetImageFromCurrentImageContext()
//        
//        UIGraphicsEndImageContext()
//        
//        return result
//    }
}
