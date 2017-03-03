//
//  UserAccountViewModel.swift
//  02微博Swift
//
//  Created by Cxd-lvdongjie on 2017/3/3.
//  Copyright © 2017年 Cxd-lvdongjie. All rights reserved.
//

import UIKit

class UserAccountViewModel {

    //单例
    static let shareInstance : UserAccountViewModel = UserAccountViewModel()
    
    
    var account : UserAccount?
    
    var accountPath : String {
        //沙盒路径
        var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        path += "/account.plist"
        return path
    }
    
    var isLogin : Bool {
        if account == nil {
            return false
        }
        guard let expires_date = account!.expires_date else {
            return false
        }
        return expires_date.compare(NSDate() as Date) == ComparisonResult.orderedDescending
        
    }
    
    // MARK:- 重写 init()函数
    init() {
        //取出数据
        account = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? UserAccount
    }
    
    
    
}
