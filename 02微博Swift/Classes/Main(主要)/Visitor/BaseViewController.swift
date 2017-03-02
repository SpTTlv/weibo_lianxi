//
//  BaseViewController.swift
//  02微博Swift
//
//  Created by Cxd-lvdongjie on 2017/3/1.
//  Copyright © 2017年 Cxd-lvdongjie. All rights reserved.
//

import UIKit

class BaseViewController: UITableViewController {

    var isLogin : Bool = false
    
    lazy var visitorView : VisitorView = VisitorView.visitorView()
    
    // MARK:- 重写系统回调
    override func loadView() {
        isLogin ? super.loadView() : setupVisitorView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationItems()
        
    }

}

extension BaseViewController {
    // MARK:- 没有登录显示的View
    func setupVisitorView(){
        
        view = visitorView
        
        //监听访客视图中  登录跟注册按钮的点击事件
        visitorView.registerBtn.addTarget(self, action: "registerBtnClick", for: .touchUpInside)
        visitorView.loginBtn.addTarget(self, action: "rloginBtnClick", for: .touchUpInside)
        
        
    }
    
    /// 设置导航栏左右的item
    func setupNavigationItems (){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: "registerBtnClick")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(BaseViewController.rloginBtnClick))
    }
    
}
// MARK:- 点击事件
extension BaseViewController{
    
    @objc private func registerBtnClick() {
        print("注册")
    }
    
    func rloginBtnClick() {

    let oauth = OAuthViewController()
        
        //包装成导航控制器
        let oauthNav = UINavigationController(rootViewController: oauth)
        
        present(oauthNav, animated: true, completion: nil)
        
    
    }
    
}




