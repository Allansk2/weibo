//
//  UIImageView+Extension.swift
//  weibo
//
//  Created by Allan-Dev1 on 2017-05-21.
//  Copyright © 2017 Allan. All rights reserved.
//

import SDWebImage

extension UIImageView {
    
    
    /// Set image from url
    ///
    /// - Parameters:
    ///   - urlString: urlString
    ///   - placeholderImage: placeholder image
    ///   - isRoundedCorner: if round corner
    func setImage(urlString: String?, placeholderImage: UIImage?, isRoundedCorner:Bool = false) {
        
        guard let urlString = urlString,
              let url = URL(string: urlString) else {
            image = placeholderImage
            return
        }
        sd_setImage(with: url, placeholderImage: placeholderImage, options: [], progress: nil) { [weak self] (image, _, _, _) in
            
            if isRoundedCorner && image != nil {
               self?.image = image?.roundedImage(size: self?.bounds.size)
            }
        }
    }
    
}
