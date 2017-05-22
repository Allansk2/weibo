//
//  BaseViewController.swift
//  weibo
//
//  Created by Allan-Dev1 on 2017-05-03.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit


class BaseViewController: UIViewController{

    // tableView - if not log in, don't create
    var tableView: UITableView?
    
    // refreshController
    var refreshControl: UIRefreshControl?
    
    // pull up refresh
    var isPullup = false
    
    // visitor info
    var visitorInfo: [String: String]?
  
    
    //create custom navigation bar
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64))
    
    //custom navigation item
    lazy var navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        NetworkManager.share.userAlreadyLogin ? loadData() : ()
        
        // register login success notification
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: NSNotification.Name(rawValue: loginSuccess), object: nil)
     }
 
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
    
    //override title didSet
    override var title: String? {
        didSet {
            navItem.title = title
        }
    }
    
    // load data - implement by child class
    func loadData() {
     
        refreshControl?.endRefreshing()
    }
}

// MARK - visitor view target
extension BaseViewController {
    
    // login success
    @objc func updateUI(n: Notification) {
        
        view = nil
        navItem.leftBarButtonItem = nil
        navItem.rightBarButtonItem = nil
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func register() {
        print(#function)
    }
    
    @objc func login() {
        print(#function)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: loginRequire), object: nil)
        
    }
    
    @objc func follow() {
        print(#function)
    }
}



// MARK - setup UI
extension BaseViewController {
    
   fileprivate func setupUI() {
        
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar()
        
        NetworkManager.share.userAlreadyLogin ? setupTableView() : setupVisitorView()
        
    }
    
    func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.insertSubview(tableView!, belowSubview: navigationBar)
        
        //set tableview datasource and delegate
        tableView?.dataSource = self
        tableView?.delegate = self
        
        tableView?.contentInset = UIEdgeInsets(top: navigationBar.bounds.height,
                                            left: 0,
                                            bottom: tabBarController?.tabBar.bounds.height ?? 49,
                                            right: 0)
        
        tableView?.scrollIndicatorInsets = tableView!.contentInset
        
        refreshControl = UIRefreshControl()
        tableView?.addSubview(refreshControl!)
        
        //add targe
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    
    private func setupVisitorView() {
        
        let visitorView = VisitorView(frame: view.bounds)
        visitorView.visitorInfo = visitorInfo
        
        //set up targer
        visitorView.registerBtn.addTarget(self, action: #selector(register), for: .touchUpInside)
        visitorView.loginBtn.addTarget(self, action: #selector(login), for: .touchUpInside)
        visitorView.followBtn.addTarget(self, action: #selector(follow), for: .touchUpInside)

        view.insertSubview(visitorView, belowSubview: navigationBar)
        
        navItem.leftBarButtonItem = UIBarButtonItem(title: "注册", target: self, action: #selector(register))
        navItem.rightBarButtonItem = UIBarButtonItem(title: "登陆",target: self, action: #selector(login))
 
        
    }
    
    private func setupNavigationBar() {
        //add navigation bar
        view.addSubview(navigationBar)
        //put navigation items to navigationbar
        navigationBar.items = [navItem]
        
        //set tint color
        navigationBar.barTintColor = UIColor(rgb: 0xF6F6F6)
        
        //set navBar titl color
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.darkGray]
        
    }
   
}

// MARK table datasource delegate
extension BaseViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        let section = tableView.numberOfSections - 1
        
        if row < 0 || section < 0 {
            return
        }
        
        // when it's the last row in last section, pull more data
//        let count = tableView.numberOfRows(inSection: section) - 1
//        if indexPath.section == section && row == count && !isPullup {
//            
//            print("pull up")
//            isPullup = true
//            
//            loadData()
//            
//        }
        
        let count = tableView.numberOfRows(inSection: section)
        if row == (count - 1) && !isPullup {
            
            print("pull up")
            isPullup = true
            
            loadData()
        }

        
    }
}
