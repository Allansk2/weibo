//
//  WelcomeView.swift
//  weibo
//
//  Created by Allan-Dev1 on 2017-05-20.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit
import SDWebImage

class WelcomeView: UIView {
 
    @IBOutlet weak var bottomCons: NSLayoutConstraint!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avartaImage: UIImageView!
    @IBOutlet weak var avartaHeight: NSLayoutConstraint!
    
    class func welcomeView() -> WelcomeView {
        
        let nib = UINib(nibName: "WelcomeView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WelcomeView

        v.frame = UIScreen.main.bounds

        return v
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let urlString = NetworkManager.share.userAccount.avatar_large,
        let url = URL(string: urlString) else {
            return
        }
        
        avartaImage.layer.cornerRadius = avartaHeight.constant * 0.5
        avartaImage.layer.masksToBounds = true
        avartaImage.sd_setImage(with: url, placeholderImage: UIImage(named: "avatar_default_big"))

    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        self.layoutIfNeeded()

        bottomCons.constant = bounds.height - 200
        
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       options: [],
                       animations: { 
                        
                        self.layoutIfNeeded()
        }) { (_) in
            
            UIView.animate(withDuration: 1.0, animations: {
                self.nameLabel.alpha = 1.0
            }, completion: { (_) in
                self.removeFromSuperview()
            })
 
        }
        
    }
    
}
