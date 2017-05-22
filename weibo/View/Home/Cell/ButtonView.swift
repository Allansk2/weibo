//
//  ButtonView.swift
//  weibo
//
//  Created by Allan-Dev1 on 2017-05-21.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

class ButtonView: UIView {

    var statusViewModel: StatusViewModel? {
        didSet{
            retweetBtn.setTitle(statusViewModel?.retweetString, for: [])
            commentBtn.setTitle(statusViewModel?.commentString, for: [])
            likeBtn.setTitle(statusViewModel?.likeString, for: [])
        }
    }
 
    
    @IBOutlet weak var retweetBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var likeBtn: UIButton!

   
    
}
