//
//  AppDelegate.swift
//  weibo
//
//  Created by Allan-Dev1 on 2017-05-03.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit
import UserNotifications
import SVProgressHUD
import AFNetworking

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
 
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
  
        setNetworkProperty()
        
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()
        
        loadControllers()
        
        return true
    }
    
    
    
}



// MARK: -
extension AppDelegate {
    
    fileprivate func setNetworkProperty() {
        
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        
        AFNetworkActivityIndicatorManager.shared().isEnabled = true
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge, .carPlay]) { (success, error) in
                
            }
        } else {
            // Fallback on earlier versions
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
            
        }
        
    }
    
}



// MARK: - get controllers
extension AppDelegate {
    
    
    fileprivate func loadControllers() {
        
        // new controllers info should be get from server
        DispatchQueue.global().async {
            
            // get url
            let url = Bundle.main.url(forResource: "controllers.json", withExtension: nil)
            
            // get data
            let data = NSData(contentsOf: url!)
            
            // write to nsdocument
            let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            let jsonFile = (docDir as NSString).appendingPathComponent("controllers.json")
            
            data?.write(toFile: jsonFile, atomically: true)
        
            
        }
        
    }
    
}

