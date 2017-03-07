//
//  AppDelegate.swift
//  02微博Swift
//
//  Created by Cxd-lvdongjie on 2017/3/1.
//  Copyright © 2017年 Cxd-lvdongjie. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var defaultViewController : UIViewController {
     
        let isLogin = UserAccountViewModel.shareInstance.isLogin
        
        return  isLogin ? WelcomeViewController() : UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
        
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        UITabBar.appearance().tintColor = UIColor.orange
        
        UINavigationBar.appearance().tintColor = UIColor.orange
        
        
        //window
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = defaultViewController
        window?.makeKeyAndVisible()
    
        return true
    }

  

}

func XL_Log<T>(_ messsage : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        
        print("\(fileName):(\(lineNum))-\(messsage)")
        
    #endif
}
