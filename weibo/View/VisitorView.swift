//
//  VisitorView.swift
//  weibo
//
//  Created by Allan-Dev1 on 2017-05-13.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

class VisitorView: UIView {

    //register button
    lazy var registerBtn = UIButton.titleButton(title: "注册",
                                            fontSize: 16,
                                            color: UIColor.orange,
                                            highlightColor: UIColor.black,
                                            backgroundImageName: "common_button_white_disable")
    
    //login button
    lazy var loginBtn = UIButton.titleButton(title: "登陆",
                                                fontSize: 16,
                                                color: UIColor.darkGray,
                                                highlightColor: UIColor.black,
                                                backgroundImageName: "common_button_white_disable")
    
    //follow button
    lazy var followBtn = UIButton.titleButton(title: "去关注",
                                             fontSize: 16,
                                             color: UIColor.orange,
                                             highlightColor: UIColor.black,
                                             backgroundImageName: "common_button_white_disable")

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init coder error")
    }
    
    
    var visitorInfo: [String: String]? {
        
        didSet {
            
            guard let message = visitorInfo?["message"],
                  let imageName = visitorInfo?["imageName"] else {
                return
            }
            
            tipLabel.text = message
            
            if imageName == "" {
                
                startAnimation()
                return
            }
            
            centerImage.image = UIImage(named: imageName)
            followBtn.isHidden = true
            rotationImage.isHidden = true
            
            
        }
        
    }
    
    
    //MARK - private UI
    fileprivate lazy var maskImage: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))

  
    fileprivate lazy var rotationImage = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    
    //center image
    fileprivate lazy var centerImage = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    
    fileprivate lazy var tipLabel = UILabel.label(text: "关注一些人，回这里看看有什么惊喜", fontSize: 14, color: UIColor.darkGray)
    
    
    
    /// add rotation animation to the center image
    private func startAnimation() {
        
        registerBtn.isHidden = true
        loginBtn.isHidden = true
        
        let ani = CABasicAnimation(keyPath: "transform.rotation")
        ani.fromValue = 0
        ani.toValue = 2 * Double.pi
        ani.repeatCount = MAXFLOAT
        ani.duration = 20
        ani.isRemovedOnCompletion = false
        
        rotationImage.layer.add(ani, forKey: "transform.rotation")
        
    }
}


extension VisitorView {
    
    func setupUI () {
        backgroundColor = UIColor(rgb: 0xEDEDED)
        
        addSubview(rotationImage)
        addSubview(maskImage)
        addSubview(centerImage)
        addSubview(tipLabel)
        addSubview(followBtn)
        addSubview(registerBtn)
        addSubview(loginBtn)

 
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // set autolayout for rotation image
        addConstraint(NSLayoutConstraint(item: rotationImage,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        
        
        addConstraint(NSLayoutConstraint(item: rotationImage,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerY,
                                         multiplier: 1.0,
                                         constant: -60))
        
        // set autolayout for rotation image
        addConstraint(NSLayoutConstraint(item: centerImage,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: rotationImage,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))

        addConstraint(NSLayoutConstraint(item: centerImage,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: rotationImage,
                                         attribute: .centerY,
                                         multiplier: 1.0,
                                         constant: 0))
        
        // set autolayout for label
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: rotationImage,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: rotationImage,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 20))
        
        
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 236))
        tipLabel.textAlignment = .center

        // set autolayout follow button
        addConstraint(NSLayoutConstraint(item: followBtn,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: rotationImage,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        
        addConstraint(NSLayoutConstraint(item: followBtn,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 20))
        
        addConstraint(NSLayoutConstraint(item: followBtn,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 100))

        
        // set autolayout register button
        addConstraint(NSLayoutConstraint(item: registerBtn,
                                         attribute: .left,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .left,
                                         multiplier: 1.0,
                                         constant: 0))
        
        addConstraint(NSLayoutConstraint(item: registerBtn,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 20))
        
        addConstraint(NSLayoutConstraint(item: registerBtn,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 100))
        
        // set autolayout login button
        addConstraint(NSLayoutConstraint(item: loginBtn,
                                         attribute: .right,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .right,
                                         multiplier: 1.0,
                                         constant: 0))
        
        addConstraint(NSLayoutConstraint(item: loginBtn,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 20))
        
        addConstraint(NSLayoutConstraint(item: loginBtn,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 100))
  
 
        let dict = ["maskImage": maskImage,
                        "registerBtn": registerBtn] as [String : Any]
  
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[maskImage]-0-|",
            options: [],
            metrics: nil,
            views: dict))
 
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[maskImage]-(-20)-[registerBtn]",
            options: [],
            metrics: nil,
            views: dict))
        
    }
    
}



 
