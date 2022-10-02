//
//
// AppDelegate.swift
// PokeApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 28/09/22.
// Copyright (c) 2022 and Confidential to ___ORGANIZATIONNAME___ All rights reserved.
//


import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if #available(iOS 15, *) {
                   let appearance = UINavigationBarAppearance()
                   appearance.configureWithTransparentBackground()
                   UINavigationBar.appearance().standardAppearance = appearance
                   UINavigationBar.appearance().scrollEdgeAppearance = appearance
                    appearance.backgroundColor  = .white
            appearance.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 17)]
        
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

