//
//  UILabel+Extension.swift
//  weibo
//
//  Created by Allan-Dev1 on 2017-05-13.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

extension UILabel {

    
    /// Init lable with text, font and color
    ///
    /// - Parameters:
    ///   - text: text
    ///   - fontSize: font size
    ///   - color: color
    /// - Returns: UILabel
    class func label(text: String, fontSize: CGFloat, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textColor = color
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }

}
