
//
//  UserAccount.swift
//  weibo
//
//  Created by Allan-Dev1 on 2017-05-14.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

private let userAccountFile = "userAccount.json"

class UserAccount: NSObject {
    
    var access_token: String?
    var uid: String?
    var expires_in: TimeInterval = 0 {
        didSet{
            expireDate = Date(timeIntervalSinceNow: expires_in)
        }
    }
    
    var expireDate: Date?
    
    // user screen name
    var screen_name: String?

    // user large image
    var avatar_large: String?

    
    override var description: String {
        return yy_modelDescription()
    }
    
    
    
    /// get user account from disk to check if already login
    override init() {
        super.init()
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonFile = (docDir as NSString).appendingPathComponent(userAccountFile)
        
        guard let data = NSData(contentsOfFile: jsonFile),
              let dict = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [String: AnyObject] else {
            return
        }
        
        yy_modelSet(with: dict ?? [:])
        
        // check if expire
    
        if expireDate?.compare(Date()) != .orderedDescending {
            access_token = nil
            uid = nil
            
            try? FileManager.default.removeItem(atPath: jsonFile)
            
        }
 
    }
    
    
    /// save user account
    func saveAccount() {
        
        var dict = self.yy_modelToJSONObject() as? [String: AnyObject] ?? [:]
        
        // remove expires_in, use expireDate
        dict.removeValue(forKey: "expires_in")
        
        // save data to nsdocument
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []) else {
            
            return
        }
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonFile = (docDir as NSString).appendingPathComponent(userAccountFile)
        
        print(jsonFile)
        (data as NSData).write(toFile: jsonFile, atomically: true)
        
    }
}
