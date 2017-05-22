//
//  HomeViewController.swift
//  weibo
//
//  Created by Allan-Dev1 on 2017-05-03.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

private let cellId = "cellId"
// retweet cell id
private let retweetCellId = "retweetCellId"

class HomeViewController: BaseViewController {
  
    /// status lists view model
    fileprivate lazy var statusListViewModel = StatusListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.red
    
     }
 
    @objc fileprivate func showFriends() {
        print(#function)
        let vc = DemonViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func loadData() {
      
        statusListViewModel.loadStatus (pullUp: isPullup) { (isSuccess, hasMore) in
            
            self.refreshControl?.endRefreshing()
            
            if hasMore {
                self.tableView?.reloadData()
            }
            
            self.isPullup = false
            
        }
         
    }
}

// MARK - table datasource
extension HomeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusListViewModel.statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let statusViewModel = statusListViewModel.statusList[indexPath.row]
        let reusedCellId = (statusViewModel.status.retweeted_status != nil) ? retweetCellId : cellId
        
        // 1 get cell
        let cell = tableView.dequeueReusableCell(withIdentifier: reusedCellId) as! statusCell
        
        // 2 set cell
        
        cell.statusViewModel = statusViewModel
        
       
        //3 return cell
        return cell
    }
}

// MARK - setup UI
extension HomeViewController {
    
    override func setupTableView() {
        super.setupTableView()
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(showFriends))
        
        // register cell
        tableView?.register(UINib(nibName: "statusCell", bundle: nil), forCellReuseIdentifier: cellId)
        tableView?.register(UINib(nibName: "statusRetweetedCell", bundle: nil), forCellReuseIdentifier: retweetCellId)

        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.estimatedRowHeight = 200
        
        tableView?.separatorStyle = .none
        
        setupNavigationTitle()
    }
    
  
    fileprivate func setupNavigationTitle() {
     
        let titleView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        titleView.backgroundColor = UIColor.clear

        let followBtn = TitleButton(title: "关注", selectedImage: "navigationbar_arrow_down")
        let hotBtn = TitleButton(title: "热门", selectedImage: "navigationbar_arrow_down")

        followBtn.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        hotBtn.frame = CGRect(x: 100, y: 0, width: 100, height: 44)
  
        titleView.addSubview(followBtn)
        titleView.addSubview(hotBtn)
        
        navItem.titleView = titleView
  
//        let followBtn = TitleButton(title: "关注", selectedImage: "navigationbar_arrow_down")
//
//        navItem.titleView = followBtn
//        
        followBtn.addTarget(self, action: #selector(clickTitleButton(btn:)), for: .touchUpInside)
    }
    
    @objc func clickTitleButton(btn: UIButton) {
        btn.isSelected = !btn.isSelected
  

    }
}
