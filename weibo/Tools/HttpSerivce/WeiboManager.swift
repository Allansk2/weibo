//
//  WeiboManager.swift
//  weibo
//
//  Created by Allan-Dev1 on 2017-05-14.
//  Copyright © 2017 Allan. All rights reserved.
//

import Foundation

extension NetworkManager {
    
  
    /// get statuses of weibo
    ///
    /// - Parameters:
    ///   - since_id: since_id
    ///   - max_id: max_id
    ///   - comletion: callback
    func getStatusList(since_id: Int64 = 0, max_id: Int64 = 0, comletion: @escaping (_ list: [[String: AnyObject]]?, _ isSuccess: Bool)-> ()) {
   
        let params = ["since_id": "\(since_id)",
            "max_id": "\(max_id > 0 ? max_id - 1: 0)"]
        
        tokenRequest(URLString: WB_STATUS_URL, parameters: params as [String : AnyObject]) { (json, isSuccess) in
            
            guard json != nil else {
                return
            }
            let statuses = (json as! NSDictionary)["statuses"] as? [[String: AnyObject]]
//            print(statuses)
            comletion(statuses, isSuccess)
        }
 
    }
    
    
    
    func unreadCount(completion: @escaping (_ count: Int) -> ()) {
        
        guard let uid = userAccount.uid else {
            return
        }
     
        let params = ["uid": uid]
        
        tokenRequest(URLString: WB_UNREAD_COUNT_URL, parameters: params as [String : AnyObject]?) { (json, isSuccess) in
            print("unread json \(json)")
            
            let dict = json as? [String: AnyObject]
            let count = dict?["status"] as? Int ?? 0
            
            completion(count)
        }
        
    }
    
}



// MARK: - user info
extension NetworkManager {
    func loadUserInfo(completion: @escaping (_ dict: [String: AnyObject])->()) {
        
        guard let uid = userAccount.uid else {
            return
        }
        
        let params = ["uid": uid]
    
        tokenRequest(URLString: WB_USER_URL, parameters: params as [String : AnyObject]?) { (json, isSuccess) in
    
            completion((json as? [String: AnyObject]) ?? [:])
        }
    }
}




// MARK: - oauth
extension NetworkManager {
    
    /// get accesstoken from access code
    func loadAccessToken(code: String, completion: @escaping (_ isSuccess: Bool)->()) {
        
        
        let params = ["client_id": WB_APP_KEY,
                      "client_secret": WB_APP_SECRET,
                      "grant_type": "authorization_code",
                      "code": code,
                      "redirect_uri": WB_REDIRECT_URL]
        

        print(WB_ACCESSTOKEN_URL)
        request(method: .POST, URLString: WB_ACCESSTOKEN_URL, parameters: params as [String : AnyObject]) { (json, isSuccess) in
            
            self.userAccount.yy_modelSet(with: json as? [String: AnyObject] ?? [:])
        
            self.loadUserInfo(completion: { (dict) in
                
                self.userAccount.yy_modelSet(with: dict)
                self.userAccount.saveAccount()
                
                print(self.userAccount)
                
                //callback
                completion(isSuccess)
                
            })
             
        }
    }
}





