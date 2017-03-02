//
//  HomeViewController.swift
//  WB练习Swift
//
//  Created by Cxd-lvdongjie on 2017/2/28.
//  Copyright © 2017年 Cxd-lvdongjie. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    
    // MARK:- 属性
    
    lazy var titleBtn : TitleButton = TitleButton()
    lazy var popAnimator : PopoverAnimator  = PopoverAnimator { [weak self] (isPresented) in
        self?.titleBtn.isSelected = isPresented
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorView.addRotationAnim()
        
        setupNavigationBar()
        
        
        NetWorkTools.shareInstance.request(methodType: .POST,urlString: "http://httpbin.org/get", params: ["name":"zhangsan" as AnyObject]) { (result, error) in


        }
        
    }
    
 
}

// MARK:- 设置导航栏按钮
extension HomeViewController{
    
    func setupNavigationBar() {
        
        navigationItem.leftBarButtonItem =  UIBarButtonItem(imageName: "navigationbar_friendattention")
        navigationItem.rightBarButtonItem =  UIBarButtonItem(imageName:"navigationbar_pop")
       
        titleBtn.setTitle("coderWhy", for: .normal)
        titleBtn.addTarget(self, action: #selector(titleViewClick(titleButton:)), for: .touchUpInside)
        navigationItem.titleView = titleBtn
        
    }
    
}

// MARK:- 点击事件
extension HomeViewController{
    
    func titleViewClick(titleButton : TitleButton) {
        titleButton.isSelected = !titleButton.isSelected
        
        
        let popVc = XLPopViewController()
        
        //设置控制器的modal样式
        popVc.modalPresentationStyle = .custom
        //设置转场动画代理
        popVc.transitioningDelegate = popAnimator
        popAnimator.presentedFrame = CGRect(x: 100, y: 50, width: 180, height: 250)
        
        present(popVc, animated: true, completion: nil)
    
    }
    
}












