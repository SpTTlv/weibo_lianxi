//
//  UIButton+Extension.swift
//  02微博Swift
//
//  Created by Cxd-lvdongjie on 2017/3/1.
//  Copyright © 2017年 Cxd-lvdongjie. All rights reserved.
//

import UIKit

extension UIButton {
    
    convenience init (imageName : String, bgImageName : String) {
        self.init()
        
        setImage(UIImage(named: imageName), for: .normal)
        setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        setBackgroundImage(UIImage(named: bgImageName), for: .normal)
        setBackgroundImage(UIImage(named: bgImageName + "_highlighted"), for: .highlighted)
        sizeToFit()
    }
    
}

