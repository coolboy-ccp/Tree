//
//  AppDelegate.swift
//  Tree
//
//  Created by 123 on 2020/6/23.
//  Copyright © 2020 ccp. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //        testUFFind()
        testUFUnion()
        return true
    }
    
    func testUFFind() {
        let uff = UFFind<Int>()
        _ = (1 ... 10).map(uff.add)
        print(uff)
        for i in 2 ... 10 {
            if i % 2 == 0 {
                uff.unionSets(first: 2, second: i)
            }
            else {
                uff.unionSets(first: 1, second: i)
            }
        }
        print(uff)
    }
    
    func testUFUnion() {
        let ufu = UFUnion<Int>()
        _ = (1 ... 10).map(ufu.add)
        print(ufu)
        for i in 2 ... 10 {
            if i % 2 == 0 {
                ufu.unionSets(first: 2, second: i)
            }
            else {
                ufu.unionSets(first: 1, second: i)
            }
        }
        print(ufu)
    }
    
    
}

