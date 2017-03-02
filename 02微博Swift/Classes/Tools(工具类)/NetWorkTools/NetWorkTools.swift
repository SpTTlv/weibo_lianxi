//
//  NetWorkTools.swift
//  02微博Swift
//
//  Created by Cxd-lvdongjie on 2017/3/2.
//  Copyright © 2017年 Cxd-lvdongjie. All rights reserved.
//

import AFNetworking

//定义枚举类型
enum RequestType : String{
    case GET = "GET"
    case POST = "POST"
}

class NetWorkTools: AFHTTPSessionManager {
        //let 是线程安全的
    static let shareInstance : NetWorkTools  = {
    
        let tools = NetWorkTools()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        
        return tools
    }()
    
    
}


// MARK:- 封装请求方法
extension NetWorkTools{
    
    
    func request(methodType : RequestType,urlString: String ,params: [String : AnyObject] ,finishedBack: @escaping (_ result : Any , _ error : NSError) -> () ) {

        //1.定义成功的回调闭包
        let successCallBack = { ( task: URLSessionDataTask, result : Any?) -> () in
            finishedBack(result, NSError())
        }
        //2.定义失败的回调闭包
        let errorCallBack = { (task : URLSessionDataTask?,error : Error) -> () in
            finishedBack("", error as NSError)
        }
        //3.发送网络请求
        if methodType == .GET {
            get(urlString, parameters: params, progress: nil, success: successCallBack, failure: errorCallBack)
        }else{
            post(urlString, parameters: params, progress: nil, success: successCallBack, failure: errorCallBack)
        }
   
        
    
    
    }

}
