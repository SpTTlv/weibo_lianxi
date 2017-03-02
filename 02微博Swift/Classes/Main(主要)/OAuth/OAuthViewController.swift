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
    
        
        
//        webView.loadRequest(URLRequest: (URL : NSURL(string:"http://www.baidu.com"))
        
        let request : NSURLRequest = NSURLRequest(url: NSURL(string:"http://www.baidu.com") as! URL)
        webView.loadRequest(request as URLRequest)
        
    }


}


// MARK:- 设置UI界面
extension OAuthViewController{
    
    
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
        print("fillItemClick填充")
        SVProgressHUD.dismiss()
        
        
        let jsCode = "document.getElementsByClassName('s_ipt nobg_s_fm_hover')[0].value = '点击了填充按钮'"
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
    
}




