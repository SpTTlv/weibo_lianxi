//
//  OAuthViewController.swift
//  02微博Swift
//
//  Created by Cxd-lvdongjie on 2017/3/2.
//  Copyright © 2017年 Cxd-lvdongjie. All rights reserved.
//

import UIKit
import SVProgressHUD

class OAuthViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        
        //加载网页
        loadPage()
        
    }


}


// MARK:- 设置UI界面
extension OAuthViewController{
    
    
    func loadPage() {
        
        let request : NSURLRequest = NSURLRequest(url: NSURL(string:"https://api.weibo.com/oauth2/authorize?client_id=\(client_id)&redirect_uri=\(redirect_uri)") as! URL)
        webView.loadRequest(request as URLRequest)
    }
    
    
    func setupNavigationBar() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: "closeItemClick")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .plain, target: self, action: "fillItemClick")
        
        // 3.设置标题
        title = "登录页面"
        
    }
    
}

// MARK:- 点击事件
extension OAuthViewController{
    
    func closeItemClick() {
        dismiss(animated: true, completion: nil)
        SVProgressHUD.dismiss()
    }
    
    func fillItemClick() {
        SVProgressHUD.dismiss()
        let jsCode = "document.getElementById('userId').value='13121530018';document.getElementById('passwd').value='miku003';"
        webView.stringByEvaluatingJavaScript(from: jsCode)
    }
    
    
}

// MARK:- webView的代理事件
extension OAuthViewController :UIWebViewDelegate{
    //webView开始加载网页
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    //webView网页加载完成
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    //webView网页加载失败
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
    }
    //是否允许webView加载
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        guard let url = request.url else {
            return true
        }
        let urlString = url.absoluteString
        
        guard urlString.contains("code=") else {
            return true
        }
        
        let code = urlString.components(separatedBy: "code=").last!
        
        NetWorkTools.shareInstance.requestWeiboData(code: code) { (result, error) in

            if error != nil{
                XL_Log(error)
            }else{

                guard let accountDict = result else{
                    XL_Log("没有数据")
                    return
                }
                //将字典转成模型
                let account = UserAccount(dict: accountDict)
                
                //请求用户信息
                self.loadUserInfo(account: account)
            }
        }
        return false
    }
    //请求用户信息
    func loadUserInfo(account: UserAccount) {
        
        guard let accessToken = account.access_token else {
            return
        }
        guard let uid = account.uid else {
            return
        }
        //发送网络请求
        NetWorkTools.shareInstance.requestUserInfo(access_token: accessToken, uid: uid) { (result, error) in
            
            //错误校验
            if error != nil{
                XL_Log(error)
                return
            }
            
            guard let userInfoDict = result else{
                return
            }
            
            account.screen_name = userInfoDict["screen_name"] as? String
            account.avatar_large = userInfoDict["avatar_large"] as? String
            
            //将account进行保存
            account.saveUserAccount()
            
            //将account单例赋值
            UserAccountViewModel.shareInstance.account = account
            
            //退出当前控制器
            self.dismiss(animated: false, completion: {
                //显示欢迎界面
                UIApplication.shared.keyWindow?.rootViewController = WelcomeViewController()
            })
            
        }
        
    }
    
    
}




