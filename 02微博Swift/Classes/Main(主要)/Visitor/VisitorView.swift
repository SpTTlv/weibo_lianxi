//
//  VisitorView.swift
//  02微博Swift
//
//  Created by Cxd-lvdongjie on 2017/3/1.
//  Copyright © 2017年 Cxd-lvdongjie. All rights reserved.
//

import UIKit

class VisitorView: UIView {
    
    
    // MARK:- 提供快速通过xib
    class func visitorView() -> VisitorView {
        return Bundle.main.loadNibNamed("VisitorView", owner: nil, options: nil)?.first as! VisitorView
    }
    
    // MARK:- 控件的属性
    @IBOutlet weak var contents: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var backView: UIImageView!
    @IBOutlet weak var circleImageView: UIImageView!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!

    // MARK:- 自定义函数
    func setupVisitorViewInfo(imageName: String , title:String){
        
        contents.text = title
        icon.image = UIImage(named:imageName)
        circleImageView.isHidden = true
    }
    
    func addRotationAnim() {
        
        //创建动画
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        
        //设置动画属性
        rotationAnim.fromValue = 0
        rotationAnim.toValue = M_PI * 2
        rotationAnim.repeatCount = MAXFLOAT
        rotationAnim.duration = 5.0
        
        rotationAnim.isRemovedOnCompletion = false
        
        //讲动画添加到layer中
        circleImageView.layer.add(rotationAnim, forKey: nil)
        
        
    }
    
    
    
    
}
