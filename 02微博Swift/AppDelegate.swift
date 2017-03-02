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


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        UITabBar.appearance().tintColor = UIColor.orange
        
        UINavigationBar.appearance().tintColor = UIColor.orange
        
        
    
        return true
    }

  

}

