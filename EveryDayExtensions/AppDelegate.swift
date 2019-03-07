//
//  AppDelegate.swift
//  EveryDayExtensions
//
//  Created by Mark Poesch on 3/5/19.
//
// The MIT License (MIT)
//
// Copyright (c) 2019 FTLapps, Inc.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import UIKit

func Log(_ me: Any, functionName: String = #function) {
    NSLog("\(String(describing: type(of: me))).\(functionName)")
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //MARK: - EveryDayExtensions

    static let appDelegate = UIApplication.shared.delegate as! AppDelegate

    // https://stackoverflow.com/questions/26667009/get-top-most-uiviewcontroller
    class func topViewController(controller: UIViewController = UIApplication.shared.keyWindow!.rootViewController!) -> UIViewController {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController!)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }

    class func invokeTopViewController(_ selector: Selector) {
        let controller = AppDelegate.topViewController()
        if controller.responds(to: selector) {
            controller.performSelector(onMainThread: selector, with: nil, waitUntilDone: true)
        }
    }

    //MARK: - UIApplicationDelegate handoff to topViewController

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Log(self)
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        Log(self)
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        AppDelegate.invokeTopViewController(#selector(applicationWillResignActive))
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        Log(self)
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        AppDelegate.invokeTopViewController(#selector(applicationDidEnterBackground))
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        Log(self)
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        AppDelegate.invokeTopViewController(#selector(applicationWillEnterForeground))
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        Log(self)
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        AppDelegate.invokeTopViewController(#selector(applicationDidBecomeActive))
    }

    func applicationWillTerminate(_ application: UIApplication) {
        Log(self)
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
