//
//  User.swift
//  02微博Swift
//
//  Created by Cxd-lvdongjie on 2017/3/6.
//  Copyright © 2017年 Cxd-lvdongjie. All rights reserved.
//

import UIKit

class User: NSObject {

    // MARK:- 属性
    var profile_image_url : String?         // 用户的头像
    var screen_name : String?               // 用户的昵称
    
    var mbrank : Int = 0 {                   // 用户的会员等级
        didSet {
            if mbrank > 0 && mbrank <= 6 {
                vipImage = UIImage(named: "common_icon_membership_level\(mbrank)")
            }
        }
    }
    
    var verified_type : Int = -1 {           // 用户的认证类型
        didSet {
            switch verified_type {
            case 0:
                verifiedImage = UIImage(named: "avatar_vip")
            case 2, 3, 5:
                verifiedImage = UIImage(named: "avatar_enterprise_vip")
            case 220:
                verifiedImage = UIImage(named: "avatar_grassroot")
            default:
                verifiedImage = nil
            }
        }
    }
    
    
    // MARK:- 对用户数据处理
    var verifiedImage : UIImage?
    var vipImage : UIImage?
    
    init(dict : [String : AnyObject]) {
        
        super.init()
        setValuesForKeys(dict)
        
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    

    
    
}
