//
//  NewFeatureView.swift
//  weibo
//
//  Created by Allan-Dev1 on 2017-05-20.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

class NewFeatureView: UIView {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var goWeiboBtn: UIButton!
    
    @IBAction func goWeibo(_ sender: Any) {
        removeFromSuperview()
    }
    
   
    class func newFeatureView() -> NewFeatureView {
        
        let nib = UINib(nibName: "NewFeatureView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! NewFeatureView
        
        v.frame = UIScreen.main.bounds
        
        return v
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // add imageviews
        let count = 4
        let rect = UIScreen.main.bounds
        for i in 0..<count {
            
            let imageName = "new_feature_\(i + 1)"
            let imageView = UIImageView(image: UIImage(named: imageName))
            imageView.frame = rect.offsetBy(dx: CGFloat(i) * rect.width, dy: 0)
            
            scrollView.addSubview(imageView)
            
        }
        
        // set scrollview attributes
        scrollView.contentSize = CGSize(width: CGFloat(count + 1) * rect.width , height: rect.height)
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.delegate = self
        
        goWeiboBtn.isHidden = true
    }
    
}


extension NewFeatureView: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        // get current page index
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
        // check if it's last page, remove from parent view
        if page == scrollView.subviews.count {
            removeFromSuperview()
        }
        
        // if last second page, show button
        goWeiboBtn.isHidden = (page != scrollView.subviews.count - 1)
    
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        goWeiboBtn.isHidden = true
        
        // get current page index
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width + 0.5)
        
        // set page controller index
        pageController.currentPage = page
        
        // if last page, hide page controller
        pageController.isHidden = (page == scrollView.subviews.count)

        
    }
    
}










