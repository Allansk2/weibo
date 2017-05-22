//
//  StatusPictureView.swift
//  weibo
//
//  Created by Allan-Dev1 on 2017-05-21.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

class StatusPictureView: UIView {

    @IBOutlet weak var heightCons: NSLayoutConstraint!
    
    var pic_urls: [StatusPicture]? {
        didSet {
            
            // hide all subviews
            for subview in subviews {
                subview.isHidden = true
            }
            
            // loop through array
            var index = 0
            for urlStr in pic_urls ?? [] {
                
                let imageView = subviews[index] as! UIImageView
                
                // 
                if index == 1 && pic_urls?.count == 4 {
                    index += 1
                }
                
                imageView.setImage(urlString: urlStr.thumbnail_pic, placeholderImage: nil)
                
                // show imageview
                imageView.isHidden = false
                
                index += 1
            }
        }
    }
    
    override func awakeFromNib() {
        setupUI()
    }
    
}


extension StatusPictureView {
    
    fileprivate func setupUI() {
        backgroundColor = superview?.backgroundColor
        
        clipsToBounds = true
        let count = 3
        let rect = CGRect(x: 0, y: StatusOutterMargin, width: singlePictureWidth, height: singlePictureWidth)
        let pictureWidth = singlePictureWidth + StatusInnerMargin
        for i in 0..<count*count {
            let imageView = UIImageView()
            
            // calculate row and column
            let row = CGFloat(i / 3)
            let col = CGFloat(i % 3)
            
            imageView.frame = rect.offsetBy(dx: CGFloat(col * pictureWidth), dy: CGFloat(row * pictureWidth))
            
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            
            addSubview(imageView)
        }
        
    }
}
