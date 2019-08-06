//
//  AppDelegate.swift
//  RxPanModal
//
//  Created by Meng Li on 08/02/2019.
//  Copyright (c) 2019 XFLAG. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let window = UIWindow()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window.rootViewController = ViewController(viewModel: .init())
        window.makeKeyAndVisible()
        return true
    }

}
