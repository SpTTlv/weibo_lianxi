//
//  NetWorkTools.swift
//  02微博Swift
//
//  Created by Cxd-lvdongjie on 2017/3/2.
//  Copyright © 2017年 Cxd-lvdongjie. All rights reserved.
//

import AFNetworking
import ReactiveSwift

//定义枚举类型
enum RequestType : String{
    case GET = "GET"
    case POST = "POST"
}

class NetWorkTools: AFHTTPSessionManager {
        //let 是线程安全的
    static let shareInstance : NetWorkTools  = {
    
        let tools = NetWorkTools(baseURL: NSURL(string:"") as URL?, sessionConfiguration: nil)
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        return tools
    }()
    
    
}


// MARK:- 封装请求方法
extension NetWorkTools{
    
    
    func request(methodType : RequestType,urlString: String ,params: [String : AnyObject] ,finishedBack: @escaping (_ result : Any?, _ error : NSError?) -> () ) {

        //1.定义成功的回调闭包
        let successCallBack = { ( task: URLSessionDataTask, result : Any?) -> () in
            finishedBack(result, nil)
        }
        //2.定义失败的回调闭包
        let errorCallBack = { (task : URLSessionDataTask?,error : Error) -> () in
            finishedBack(nil, error as NSError)
        }
        //3.发送网络请求
        if methodType == .GET {
            get(urlString, parameters: params, progress: nil, success: successCallBack, failure: errorCallBack)
        }else{
            post(urlString, parameters: params, progress: nil, success: successCallBack, failure: errorCallBack)
        }
   
    }

}

// MARK:- 微博返回数据
extension NetWorkTools{

    func requestWeiboData(code : String , finished : @escaping (_ result : [String : AnyObject]? ,_ error : NSError?)-> ()) {
        
        let params = ["client_id" : client_id , "client_secret" : client_secret , "grant_type":"authorization_code" ,"code":code ,"redirect_uri" : redirect_uri]
        
        request(methodType: .POST, urlString: "https://api.weibo.com/oauth2/access_token", params: params as [String : AnyObject]) { (result, error) in
            
            finished(result as? [String : AnyObject],error)
        }
        
    
        
    }
    
}

// MARK:- 加载用户信息
extension NetWorkTools{

    func requestUserInfo(access_token : String, uid : String, finished : @escaping (_ result : [String : AnyObject]?,_ error : NSError?) -> ()) {
        
        let urlString = "https://api.weibo.com/2/users/show.json"
        
        let params = ["access_token" : access_token, "uid" : uid]
        
        request(methodType: .GET, urlString: urlString, params: params as [String : AnyObject]) { (result, error) in
            
            finished(result as?[String: AnyObject] , error)
            
        }
        
    }

}

// MARK:- 请求首页的数据
extension NetWorkTools{
    
    func loadHomeStatus(finished : @escaping (_ result : [[String : AnyObject]]?,_ error : NSError?) -> ()) {
        
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let params = ["access_token" : (UserAccountViewModel.shareInstance.account?.access_token)!]
       
        print(params)
        //发送网络请求
        request(methodType: .GET, urlString: urlString, params: params as [String : AnyObject]) { (result, error) in
            
            guard let resultDic = result as? [String : AnyObject] else{
                finished(nil, error)
                return
            }
            
            finished(resultDic["statuses"] as? [[String : AnyObject]] ,error)
            
            
        }
        
    }
    
}

// MARK:- RAC方法
extension NetWorkTools{
    
    func rac_request(){
        print("rac_request")
        
        let (signal, observer) = Signal<String, NSError>.pipe()
        
        signal.observe(Signal.Observer{
            
            print("hahah")
        })
        
        observer.send(value: "a")     // Prints A
        observer.send(value: "b")     // Prints B
        observer.send(value: "c")     // Prints C


        
    }
    
}


