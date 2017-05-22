//
//  Status.swift
//  weibo
//
//  Created by Allan-Dev1 on 2017-05-14.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit
import YYModel

/// Weibo status model
class Status: NSObject {
    
    var id: Int64 = 0
    var text: String?
    
    // user of a status
    var user: StatusUser?
    
    // retweet count
    var reposts_count: Int = 0
    
    // comment count
    var comments_count: Int = 0
    
    // like count
    var attitudes_count: Int = 0
    
    // status picture array
    var pic_urls: [StatusPicture]?
    
    // retweet status
    var retweeted_status: Status?
    
      
    override var description: String {
        return yy_modelDescription()
    }
    
    // class function to conver pic_urls to model object
    class func modelContainerPropertyGenericClass() -> [String: AnyClass] {
        return ["pic_urls":StatusPicture.self]
    }
    
}
