//
//  StatusListViewModel.swift
//  weibo
//
//  Created by Allan-Dev1 on 2017-05-14.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit

// max try time when fail
private let maxTryTimes = 3

/// status list view model
class StatusListViewModel {
    
    // status view model
    lazy var statusList = [StatusViewModel]()
    
    private var errorTime = 0
    
    /// get status lists
    func loadStatus(pullUp: Bool, completion: @escaping (_ isSuccess: Bool, _ shouldRefresh: Bool)-> ()) {
        
        if pullUp && errorTime > maxTryTimes {
            completion(false, false)
            return
        }
        // set since_id
        let since_id = pullUp ? 0 : (statusList.first?.status.id ?? 0)
        
        // set max_id
        let max_id = pullUp ? (statusList.last?.status.id ?? 0 ): 0
        
        NetworkManager.share.getStatusList (since_id: since_id, max_id: max_id) { (list, isSuccess) in
            
            if !isSuccess {
                completion(false, false)
                return
            }
            
            var array = [StatusViewModel]()
            
            for dict in list ?? [] {
                
                // get model from dictionary
                guard let status = Status.yy_model(with: dict) else {
                    continue
                }
                
                // append model to array
                array.append(StatusViewModel(status: status))
                
                
            }
            
            print("new status \(array.count), status data \(array)")
 
            // append data
            if pullUp {
                self.statusList += array
            }else {
                self.statusList = array + self.statusList
            }
            
            // return callback
            if pullUp && array.count == 0 {
                
                self.errorTime += 1
                
                completion(isSuccess, false)
            }else {
                completion(isSuccess, true)
            }
             
            
            
        }
    }
    
}
