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
    
    lazy var statusArr : [Status] = [Status]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        visitorView.addRotationAnim()
        
        //设置导航栏内容
        setupNavigationBar()
        
        //请求数据
        loadStatuses()
        
        
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

// MARK:- 请求数据
extension HomeViewController{
    
    func loadStatuses() {
        NetWorkTools.shareInstance.loadHomeStatus { (result, error) in
            
            //错误校验
            if error != nil{
                return
            }
            
            guard let resultArray = result else{
                return
            }
            
            for statusDic in resultArray {
                let statusItem = Status(dict: statusDic)
                self.statusArr.append(statusItem)
            }
            
        }
    }
    
}










