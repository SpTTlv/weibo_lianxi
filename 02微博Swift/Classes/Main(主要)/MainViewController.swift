//
//  MainViewController.swift
//  WB练习Swift
//
//  Created by Cxd-lvdongjie on 2017/2/28.
//  Copyright © 2017年 Cxd-lvdongjie. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    private lazy var composeBtn :UIButton = UIButton(imageName: "tabbar_compose_icon_add", bgImageName: "tabbar_compose_button")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        tabBar.addSubview(composeBtn)

        composeBtn.center = CGPoint(x: tabBar.center.x, y: tabBar.bounds.size.height * 0.5)
        
        composeBtn.addTarget(self, action: "composeBtnClick", for: .touchUpInside)
    }


}

extension MainViewController {
    
    @objc private func composeBtnClick() {
        print("点击了中间按钮")
    }
    
}
