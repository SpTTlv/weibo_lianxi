//
//  WelcomeViewController.swift
//  02微博Swift
//
//  Created by Cxd-lvdongjie on 2017/3/3.
//  Copyright © 2017年 Cxd-lvdongjie. All rights reserved.
//

import UIKit
import SDWebImage

class WelcomeViewController: UIViewController {

    // MARK:- 属性
    
    @IBOutlet weak var iconViewBottomCons: NSLayoutConstraint!
    
    @IBOutlet weak var iconView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置头像
        let profileUrl = UserAccountViewModel.shareInstance.account?.avatar_large
        // ?? : 如果??前面的可选类型有值,那么将前面的可选类型进行解包并且赋值
        // 如果??前面的可选类型为nil,那么直接使用??后面的值
        let url  = NSURL(string: profileUrl ?? "")
        iconView.sd_setImage(with: url as URL?, placeholderImage: UIImage(named:"avatar_default_big"))

    }
    override func viewDidAppear(_ animated: Bool) {
        //改变约束的值
        iconViewBottomCons.constant = UIScreen.main.bounds.size.height - 200
        //执行动画
        //usingSpringWithDamping : 阻力系数  :阻力系数越大  弹动的效果越不明显 取值0-1
        //initialSpringVelocity : 初始化速度
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5.0, options: [], animations: {
            
            self.view.layoutIfNeeded()
            
        }) { (_) in
            UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        }

    }

}
