//
//  XLPresentationController.swift
//  02微博Swift
//
//  Created by Cxd-lvdongjie on 2017/3/2.
//  Copyright © 2017年 Cxd-lvdongjie. All rights reserved.
//

import UIKit

class XLPresentationController: UIPresentationController {

    var presetnedFrame : CGRect = CGRect.zero
    //蒙版
    fileprivate lazy var coverView :UIView = UIView()
    
    // MARK:- 系统回调函数
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        //设置弹出view的尺寸
        presentedView!.frame  = presetnedFrame
        
        //添加蒙版
        setupCoverView()
    }
    
    
}

extension XLPresentationController{
    
    func setupCoverView() {
        
        //1.添加蒙版
        containerView?.insertSubview(coverView, at: 0)
        
        //2.设置蒙版属性
        coverView.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
        coverView.frame = (containerView?.frame)!
        
        //3.添加手势
        let tapGes = UITapGestureRecognizer(target: self, action: "coverViewClick")
        coverView.addGestureRecognizer(tapGes)
        
        
    }
}

// MARK:- 点击事件
extension XLPresentationController{
    
    func coverViewClick(){
        
        presentedViewController.dismiss(animated: true, completion: nil)
        
    }
    
}
