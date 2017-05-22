//
//  MainViewController.swift
//  weibo
//
//  Created by Allan-Dev1 on 2017-05-03.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit
import SVProgressHUD

class MainViewController: UITabBarController {

    fileprivate var timer: Timer?
    
    lazy var composeButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupChildControllers()
        setupComposeButton()
        setupTimer()
        
        setupNewFeatureView()
        
        // delegate
        delegate = self
        
        // register login notification
        NotificationCenter.default.addObserver(self, selector: #selector(userLogin), name: NSNotification.Name(rawValue: loginRequire), object: nil)
    
    }

 
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    deinit {
        timer?.invalidate()
        NotificationCenter.default.removeObserver(self)
    }
    
    // response to login notification
    // present oauth login view controller
    @objc private func userLogin(notification: Notification) {
        
        var when = DispatchTime.now()
        
        if notification.object != nil {
            SVProgressHUD.setDefaultMaskType(.gradient)
            SVProgressHUD.showInfo(withStatus: "用户登陆超时，请重新登陆")
            
            when = DispatchTime.now() + 2
        }
        
        DispatchQueue.main.asyncAfter(deadline: when) {
            SVProgressHUD.setDefaultMaskType(.clear)

            let vc = OAuthController()
            let nav = UINavigationController(rootViewController: vc)
            
            self.present(nav, animated: true, completion: nil)
        }
        
    }
    
    
    // MARK 
    @objc fileprivate func composeStatus() {
        print("compose")
        
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.red
        let nvc = UINavigationController(rootViewController: vc)
        present(nvc, animated: true, completion: nil)
        
    }
    
 
}


// MARK - Newfeature view 
extension MainViewController {
    
    fileprivate func setupNewFeatureView() {
        
        // if user not login, show the visitor view
        if !NetworkManager.share.userAlreadyLogin {
            return
        }
        
        // else show welcome or newfeature view
        let v = hasNewFeature ? NewFeatureView.newFeatureView() : WelcomeView.welcomeView()

        view.addSubview(v)
        
        
    }
    
    private var hasNewFeature: Bool {
        
        // 1. get current app version
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        
        // 2. get app version in defaults
        let version = UserDefaults.standard.string(forKey: "app_version") ?? ""

        // 3. save current version to defaults
        UserDefaults.standard.set(currentVersion, forKey: "app_version")
        
        return currentVersion != version
  
    }
}



// MARK - delegate
extension MainViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        // get index of view controller
        let index = (childViewControllers as NSArray).index(of: viewController)
        
        // double click home page, should go to top and refresh data
        if selectedIndex == 0 && index == selectedIndex {
            
            let nav = childViewControllers[0] as! UINavigationController
            let vc = nav.childViewControllers[0] as! HomeViewController
            
            // tableview back to top
            vc.tableView?.setContentOffset(CGPoint(x: 0, y: -64), animated: true)
            
            // add delay to make sure tableview is scroll to top, then refresh data
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                vc.loadData()
            })
            
            // clear badge number
            vc.tabBarItem.badgeValue = nil
            UIApplication.shared.applicationIconBadgeNumber = 0
            
        }
         
        return !viewController.isMember(of: UIViewController.self)
        
    }
}

// MARK- timer
extension MainViewController {
    
    fileprivate func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        
        if !NetworkManager.share.userAlreadyLogin {
            return
        }

        NetworkManager.share.unreadCount { (count) in
            print(#function)
            // set home page tabbar item count
            self.tabBar.items?[0].badgeValue = count > 0 ? "\(count)" : nil
            UIApplication.shared.applicationIconBadgeNumber = count
        }
        
    }
}



extension MainViewController {
    
    // set compose button
    fileprivate func setupComposeButton() {
        composeButton.setImage(UIImage(named: "tabbar_compose_icon_add"), for: [])
        composeButton.setBackgroundImage(UIImage(named: "tabbar_compose_button"), for: [])
        composeButton.sizeToFit()
        
        tabBar.addSubview(composeButton)
        
        // calculate compose button frame
        let count = childViewControllers.count
        let w = tabBar.bounds.width / CGFloat(count)
        
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
        composeButton.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
        
 
    }
    
    
    /// add child controllers
    fileprivate func setupChildControllers() {
        
        // get json file path from document directory
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonFile = (docDir as NSString).appendingPathComponent("controllers.json")
        
        // get data
        var data = NSData(contentsOfFile: jsonFile)
        
        // if data not exist, get controllers from bundle
        if data == nil {
            let path = Bundle.main.path(forResource: "controllers.json", ofType: nil)!
            data = NSData(contentsOfFile: path)
            
        }
  
        // convert data to json object
        guard let array = try? JSONSerialization.jsonObject(with: data! as Data, options: []) as?[[String: AnyObject]]  else {
            return
        }
      
        // create controllers from json object
        var arrayM = [UIViewController]()
        for dict in array! {
            arrayM.append(controller(dict: dict))
        }
        
        viewControllers = arrayM
    }
    
    
    /// convert dictionary to UIController
    ///
    /// - Parameter dict:
    /// - Returns:
    private func controller(dict: [String: AnyObject]) -> UIViewController {
        
        //get dictionary value
        guard let clsName = dict["clsName"] as? String,
              let clstitile = dict["title"] as? String,
              let imageName = dict["imageName"] as? String,
              let visitorInfo = dict["visitorInfo"] as? [String: String],
              let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? BaseViewController.Type
            else {
                
                return UIViewController()
        }
        
        //create child viewcontroller
        //turn className to cls
        let vc = cls.init()
        
        vc.visitorInfo = visitorInfo
        
        //set image
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        //set tab bar title font
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.orange], for: .highlighted)
        //default font size 12, set font size for normal state
        vc.tabBarItem.setTitleTextAttributes(
            [NSFontAttributeName: UIFont.systemFont(ofSize: 12)],
            for: UIControlState(rawValue: 0))
        
        vc.title = clstitile
        
        let nav = NavigationController(rootViewController: vc)
        
        return nav
        
    }
    
    
}
