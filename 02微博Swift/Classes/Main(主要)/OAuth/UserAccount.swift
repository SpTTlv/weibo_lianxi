//
//  UserAccount.swift
//  02微博Swift
//
//  Created by Cxd-lvdongjie on 2017/3/3.
//  Copyright © 2017年 Cxd-lvdongjie. All rights reserved.
//

import UIKit

class UserAccount: NSObject ,NSCoding{
    
    // MARK:- 属性
    /// 授权AccessToken
    var access_token : String?
    /// 过期时间-->秒
    var expires_in : TimeInterval = 0.0 {
        didSet{
            expires_date = NSDate(timeIntervalSinceNow: expires_in)
        }
    }
    /// 用户ID
    var uid : String?
    
    /// access_token过期日期
    var expires_date: NSDate?
    
    
    /// 昵称
    var screen_name : String?
    
    /// 用户的头像地址
    var avatar_large : String?
    
    
    // MARK:- 自定义构造函数
    init(dict : [String : AnyObject]){
        super.init()
        
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    // MARK:- 重写description属性
    override var description: String {
        return dictionaryWithValues(forKeys: ["access_token","expires_date","uid","screen_name","avatar_large"]).description
    }
    
    
    //归档
    func encode(with aCoder: NSCoder) {
        aCoder.encode(access_token, forKey: "access_token") //token
        aCoder.encode(expires_date, forKey: "expires_date")     //过期时间
        aCoder.encode(screen_name, forKey: "screen_name")   //用户昵称
        aCoder.encode(avatar_large, forKey: "avatar_large") //用户头像地址
        aCoder.encode(uid, forKey: "uid")                   //用户ID

    }

    //解档
    required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        expires_date = aDecoder.decodeObject(forKey: "expires_date") as? NSDate
        screen_name = aDecoder.decodeObject(forKey: "screen_name") as? String
        avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
        uid = aDecoder.decodeObject(forKey: "uid") as? String

    }
    
    
}

// MARK:- 保存
extension UserAccount{
    func saveUserAccount()  {
        
        //1.0获取沙盒路径
        var accountPath =  NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        accountPath += "/account.plist"
        
        NSKeyedArchiver.archiveRootObject(self, toFile: accountPath)

    }
}
