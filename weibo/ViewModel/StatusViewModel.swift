//
//  StatusViewModel.swift
//  weibo
//
//  Created by Allan-Dev1 on 2017-05-21.
//  Copyright © 2017 Allan. All rights reserved.
//

import Foundation
import UIKit

/// Single status view model
class StatusViewModel: CustomStringConvertible {
    
    // status model
    var status: Status
  
    // member icon image
    var memberImage: UIImage?
    
    // vip image
    var vipImage: UIImage?
    
    // retweet text
    var retweetString: String?
    
    // comment text
    var commentString: String?
    
    // like text
    var likeString: String?
    
    // picture view size
    var pictureViewSize = CGSize()
    
   
    var picUrls: [StatusPicture]? {
        return status.retweeted_status?.pic_urls ?? status.pic_urls
    }
    
    var retweetText: String?
    
    init(status: Status) {
        self.status = status
        
        if (status.user?.mbrank)! > 0 && (status.user?.mbrank)! < 7 {
            let imageName = "common_icon_membership_level\(status.user?.mbrank ?? 1)"
            
            memberImage = UIImage(named: imageName)
            
            switch status.user?.verified_type ?? -1 {
            case 0:
                vipImage = UIImage(named: "avatar_vip")
            case 2, 3 ,5:
                vipImage = UIImage(named: "avatar_enterprise_vip")
            case 220:
                vipImage = UIImage(named: "avatar_grassroot")
            default:
                break
            }
        }
        
        // set button titles
        retweetString = count2String(count: status.reposts_count, defaultStr: "转发")
        commentString = count2String(count: status.comments_count, defaultStr: "评论")
        likeString = count2String(count: status.attitudes_count, defaultStr: "赞")
        
        pictureViewSize = calculatePictureViewSize(count: picUrls?.count)
        
        retweetText = "@\(status.retweeted_status?.user?.screen_name ?? "")"
            + ":"
            + (status.retweeted_status?.text ?? "")
        
    }
    
    var description: String {
        return status.description
    }
    
 
    /// turn count to text
    ///
    /// - Parameters:
    ///   - count: count
    ///   - default: default text
    /// - Returns: description text
    private func count2String(count: Int, defaultStr: String) -> String{
        
        if count == 0 {
            return defaultStr
        }
        
        if count < 10000 {
            return count.description
        }
        
        return String(format: "%.02f 万", Double(count) / 10000)
 
    }
    
    
    /// Calculate the size of picture view for a given count of image
    ///
    /// - Parameter count: count
    /// - Returns:
    private func calculatePictureViewSize(count: Int?) -> CGSize {
        
        guard let count = count else {
            return CGSize()
        }
        
        if count == 0 {
            return CGSize()
        }
        
        // picture view height
        // get rows
        let row = (count - 1) / 3 + 1
        
        let statusPictureViewHeight = StatusOutterMargin + singlePictureWidth * CGFloat(row) + StatusInnerMargin * CGFloat(row - 1)
        
        
        return CGSize(width: statusPictureViewWidth, height: statusPictureViewHeight)
    }
    
    
}
