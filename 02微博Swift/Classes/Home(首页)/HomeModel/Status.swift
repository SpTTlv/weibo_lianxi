//
//  Status.swift
//  02微博Swift
//
//  Created by Cxd-lvdongjie on 2017/3/3.
//  Copyright © 2017年 Cxd-lvdongjie. All rights reserved.
//

import UIKit

class Status: NSObject {

    // MARK:- 属性
    var created_at : String? // {              // 微博创建时间
//        didSet{
//         
//            guard let created_at = created_at else {
//                return
//            }
//            //对时间的处理
//            creatAtText = NSDate.createDateString(createAtStr: created_at)
//        }
//    }
    var source : String?
    //{                   // 微博来源
//        didSet {
//            guard let source = source, source != "" else {
//                return
//            }
//            
//            let startIndex = (source as NSString).range(of: ">").location + 1
//            let length = (source as NSString).range(of: "</").location - startIndex
//            
//            //截取字符串
//            sourceText = (source as NSString).substring(with:NSRange(location: startIndex, length: length))
//        }
//    }
    var text : String?                      // 微博的正文
    var mid : Int = 0                       // 微博的ID
    var user : User?                    //微博的用户
    var pic_urls : [[String : String]]? //微博配图
    
    // MARK:- 对数据的处理
    //var sourceText : String?  //微博来源处理
    //var creatAtText : String? //对微博创建时间的处理
    
    // MARK:- 自定义构造函数
    init(dict : [String : AnyObject]) {
        
        super.init()
        
        setValuesForKeys(dict)
        
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "user" {
            if let dict = value as? [String : AnyObject]{
                user = User(dict: dict)
            }
            return
        }
        super.setValue(value, forKey: key)
    }
    
    override var description : String {
        
        return dictionaryWithValues(forKeys: ["created_at", "id", "text", "source", "user"]).description
        
    }
    
}
