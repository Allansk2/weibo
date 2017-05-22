//
//  OAuthController.swift
//  weibo
//
//  Created by Allan-Dev1 on 2017-05-14.
//  Copyright © 2017 Allan. All rights reserved.
//

import UIKit
import SVProgressHUD

class OAuthController: UIViewController {

    private lazy var webView = UIWebView()
    
    override func loadView() {
        
        view = webView
        view.backgroundColor = UIColor.white
        
        // set delegate
        webView.delegate = self
        
        // cancel scroll
        webView.scrollView.isScrollEnabled = false
        
        title = "登陆新浪微博"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", target: self, action: #selector(goBack), isBack: true)
  
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        print(WB_AUTHORIZE_URL)
        // load oauth webview
        guard let url = URL(string: WB_AUTHORIZE_URL) else {
            return
        }
        
        let request = URLRequest(url: url)
        webView.loadRequest(request)
    }
 
    // dismiss
     @objc fileprivate func goBack() {
        SVProgressHUD.dismiss()
        dismiss(animated: true, completion: nil)
    }
    
 

}


extension OAuthController: UIWebViewDelegate {
    
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let absoluteString = request.url?.absoluteString
        
        print("shouldStartLoadWith \(absoluteString)" )
        // if fail, return
        if absoluteString?.hasPrefix(WB_REDIRECT_URL) == false {
            return true
        }
        
        // if cancel, return
        if request.url?.query?.hasPrefix("code") == false {
            goBack()
            return false
        }
        
        let code = request.url?.query?.substring(from: "code=".endIndex) ?? ""
        print("code \(code)" )

        NetworkManager.share.loadAccessToken(code: code) { (isSuccess) in
            
            if !isSuccess {
                SVProgressHUD.showInfo(withStatus: "网络请求失败，请重试")
            }else {
                // send notification to load data
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: loginSuccess), object: nil)
                
                // dismiss
                self.goBack()
            }
        }
        
        
        return true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
}


