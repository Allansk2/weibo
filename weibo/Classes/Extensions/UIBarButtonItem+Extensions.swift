//
//  UIBarButtonItem+Extensions.swift
//  weibo
//
//  Created by Allan-Dev1 on 2017-05-12.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    /// create a custom UIBarButtonItem
    ///
    /// - Parameters:
    ///   - title: title of button
    ///   - fontSize: font size (optional)
    ///   - target: target
    ///   - action: action
    ///   - isBack: if is back button, add <
    convenience init(title: String, fontSize: CGFloat = 16, target: Any?, action: Selector, isBack: Bool = false) {
        let btn = UIButton()
        btn.setTitle(title, for: [])
//        btn.setTitleColor(UIColor.darkGray, for: [])
        btn.setTitleColor(UIColor.orange, for: [])
        btn.setTitleColor(UIColor.orange, for: .highlighted)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
      
        if isBack {
            let imageName = "navigationbar_back_withtext"
//            btn.setImage(UIImage(named: imageName), for: [])
            btn.setImage(UIImage(named: imageName + "_highlighted"), for: [])
            btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
            

        }
  
        btn.sizeToFit()
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        self.init(customView: btn)
    }
    
}
