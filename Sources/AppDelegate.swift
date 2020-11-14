//
//  AppDelegate.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/02.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        registerProviderFactories()

        let appComponent = AppComponent.instance
        appComponent.tasksRepository.initialize()

        return true
    }
}
