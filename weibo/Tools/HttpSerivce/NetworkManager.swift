//
//  NetworkManager.swift
//  weibo
//
//  Created by Allan-Dev1 on 2017-05-14.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit
import AFNetworking

enum HTTPMETHOD {
    case GET
    case POST
}

class NetworkManager: AFHTTPSessionManager {

    static let share: NetworkManager = {
        let instance = NetworkManager()
        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return instance
    }()
    
  
    lazy var userAccount = UserAccount()
    
    var userAlreadyLogin: Bool {
        return userAccount.access_token != nil
    }
    
    // get token network request
    func tokenRequest(method: HTTPMETHOD = .GET, URLString: String, parameters: [String: AnyObject]?, completion: @escaping (_ json: Any?, _ success: Bool)->()) {
        
        // get access token
        guard let token = userAccount.access_token else {
            print("token not valid")
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: loginRequire), object: nil)
              
            completion(nil, false)
            return
        }
        
        // get parameters
        var parameters = parameters
        if parameters == nil {
            parameters = [String: AnyObject]()
        }
        
        parameters!["access_token"] = token as AnyObject
        
        
        request(URLString: URLString, parameters: parameters, completion: completion)
        
    }
    
    
    /// request http service
    ///
    /// - Parameters:
    ///   - method: GET / POST
    ///   - URLString: url
    ///   - parameters: parameters
    ///   - completion: completion callback
    func request(method: HTTPMETHOD = .GET, URLString: String, parameters: [String: AnyObject]?, completion: @escaping (_ json: Any?, _ success: Bool)->()) {
        
        print("parameters \(String(describing: parameters))")

        let success = { (task: URLSessionDataTask, json: Any?)-> () in
            completion(json, true)
        }
        
        let failure = { (task: URLSessionDataTask?, error: Error)-> () in
            
            if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
                
                print("token expire here ")
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: loginRequire), object: "token expire")
            }
            
            completion(nil, false)
            
            print("network error \(error.localizedDescription)")
        }
        
        if method == .GET {
            
            get(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }else {
            
            post(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
            
        }
        
    }
    
    
    
}
