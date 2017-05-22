//
//  TitleButton.swift
//  weibo
//
//  Created by Allan-Dev1 on 2017-05-20.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit


/// Custom button
/// if selectedImage == nil, it's the default system title
/// if selectedImage != nil, lightGray for [], black for selected
///                          imageView is hidden for [], not hidden for selected
//                           imageView is on right hand side of label
class TitleButton: UIButton {

    init(title: String, selectedImage: String?) {
        super.init(frame: CGRect())
        
        if selectedImage == nil {
            // if selectedImage not set, it's a normal title
            setTitle(title, for: [])
            setTitleColor(UIColor.black, for: [])

        }else {
            // if selectedImage is set, it's a custom title
            setTitle(title + " ", for: [])
            setImage(UIImage(named: selectedImage!), for: [])
            setImage(UIImage(named: selectedImage!), for: .selected)
            imageView?.isHidden = true
        
            setTitleColor(UIColor.lightGray, for: [])
            setTitleColor(UIColor.black, for: .selected)
        }
        
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        
        sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let titleLabel = titleLabel,
              let imageView = imageView else {
             return
        }
        
        imageView.isHidden = !isSelected
        titleLabel.frame = titleLabel.frame.offsetBy(dx: -imageView.bounds.width, dy: 0)
        imageView.frame = imageView.frame.offsetBy(dx: titleLabel.bounds.width, dy: 0)
        
    }
    

}
