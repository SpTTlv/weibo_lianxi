//
//  UIBarButtonItem+Extension.swift
//  02微博Swift
//
//  Created by Cxd-lvdongjie on 2017/3/2.
//  Copyright © 2017年 Cxd-lvdongjie. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(imageName: String) {
        
        self.init()
        
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named:imageName + "_highlighted"), for: .highlighted)
        btn.sizeToFit()
        
        self.customView = btn
        
    }
    
    
}
