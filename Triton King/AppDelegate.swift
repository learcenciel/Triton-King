//
//  AppDelegate.swift
//  Triton King
//
//  Created by Alexander on 31.10.2019.
//  Copyright © 2019 Alexander Team. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyBtjU15D1l96o2iCzf8kaMjhQOd2UN4Aew")
        return true
    }
}

