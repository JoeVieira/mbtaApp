//
//  AppDelegate.swift
//  Ttimer
//
//  Created by Joe Vieira on 6/1/16.
//  Copyright © 2016 Joe Vieira. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var api: MBTA_API? = nil;
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        api = MBTA_API();
        return true
    }

    func applicationDidEnterBackground(application: UIApplication) {
        api!.pause();
    }

    func applicationWillEnterForeground(application: UIApplication) {
        if ((api) != nil) {
            api!.start();
        }
        else {
            api = MBTA_API();
        }
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

