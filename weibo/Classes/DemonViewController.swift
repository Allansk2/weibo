//
//  WBDemonViewController.swift
//  weibo
//
//  Created by Allan-Dev1 on 2017-05-12.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

class DemonViewController: BaseViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set title
        title = "第\(navigationController?.childViewControllers.count ?? 0)个"
        
        view.backgroundColor = UIColor.blue
    }
    
    @objc fileprivate func showNext () {
        
        let vc = DemonViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension DemonViewController {
    
    override func setupTableView() {
        super.setupTableView()
        navItem.rightBarButtonItem = UIBarButtonItem(title: "下一个", target: self, action: #selector(showNext))
        
    }
    
    
 
}
