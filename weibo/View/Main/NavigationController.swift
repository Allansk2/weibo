//
//  NavigationController.swift
//  weibo
//
//  Created by Allan-Dev1 on 2017-05-03.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide default navigationbar
        navigationBar.isHidden = true
        
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        // if it's not root viewcontroller, hide bottom bar
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            
            // override the back button
            if let vc = viewController as? BaseViewController {
                
                var title = "返回"

                if childViewControllers.count == 1 {
                    title = childViewControllers.first?.title ?? "返回"
                }
                
                // get defined navItem
                vc.navItem.leftBarButtonItem = UIBarButtonItem(title: title, target: self, action: #selector(popToParent), isBack: true)
            }
        }
         
        super.pushViewController(viewController, animated: true)
        
    }
    
    //pop to previous view controller
    @objc private func popToParent() {
        popViewController(animated: true)
    }

}
