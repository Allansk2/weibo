//
//  UIButton+Extension.swift
//  weibo
//
//  Created by Allan-Dev1 on 2017-05-13.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

import UIKit

extension UIButton {
    
  
    
    /// Init button with attributes
    ///
    /// - Parameters:
    ///   - title: title
    ///   - fontSize: font size
    ///   - color: color
    ///   - highlightColor: hightlighted color
    ///   - backgroundImageName: background image
    /// - Returns: UIButton
    class func titleButton(title: String, fontSize: CGFloat, color: UIColor, highlightColor: UIColor?, backgroundImageName: String?) -> UIButton {
        let btn = UIButton()
        btn.setTitle(title, for: [])
        btn.setTitleColor(color, for: [])
        if let highlightColor = highlightColor {
            btn.setTitleColor(highlightColor, for: .highlighted)
        }
        btn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        if let imageName = backgroundImageName {
            btn.setBackgroundImage(UIImage(named: imageName), for: [])
            let imageNameHL = imageName.appending("_highlighted")
            btn.setBackgroundImage(UIImage(named: imageNameHL), for: .highlighted)
        }
        
        btn.sizeToFit()
        
        return btn
    }
    
    
 
    
    /// Init button with image and background image
    ///
    /// - Parameters:
    ///   - imageName: image name
    ///   - backgroundImageName: background image name
    /// - Returns: UIButton
    class func imageButton(imageName: String, backgroundImageName: String?) -> UIButton {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        
        if let backgroundImageName = backgroundImageName {
            btn.setBackgroundImage(UIImage(named: backgroundImageName), for: .normal)
            btn.setBackgroundImage(UIImage(named: backgroundImageName + "highlighted"), for: .highlighted)
        }
        
        btn.sizeToFit()
        
        return btn
    }
    
    
    class func titleButton(title: String, fontSize: CGFloat, color: UIColor, selectedColor: UIColor?, backgroundImageName: String?) -> UIButton {
        let btn = UIButton()
        btn.setTitle(title, for: [])
        btn.setTitleColor(color, for: [])
        if let selectedColor = selectedColor {
            btn.setTitleColor(selectedColor, for: .selected)
        }
        btn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        if let imageName = backgroundImageName {
            btn.setBackgroundImage(UIImage(named: imageName), for: [])
            let imageNameHL = imageName.appending("_highlighted")
            btn.setBackgroundImage(UIImage(named: imageNameHL), for: .highlighted)
        }
        
        btn.sizeToFit()
        
        return btn
    }

}

