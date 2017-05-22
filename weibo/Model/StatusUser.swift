//
//  StatusUser.swift
//  weibo
//
//  Created by Allan-Dev1 on 2017-05-21.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit


/// Users for all status message
class StatusUser: NSObject {
    
    var id: Int64 = 0
  
    // user screen name
    var screen_name: String?
    
    // user image url
    var profile_image_url: String?
    
    // verified type, 1. no verified, 2.3.5 enterprise  220. expertise
    var verified_type: Int = 0
    
    // member 
    var mbrank: Int = 0
    
    override var description: String {
        return yy_modelDescription()
    }

    

}
