//
//  AppComponent.swift
//  TodoApp
//
//  Created by Shinya Kumagai on 2020/11/01.
//

import Core
import Foundation
import NeedleFoundation

protocol AppDependency: Dependency {
    var tasksRepository: TasksRepository { get }
}

class AppComponent: Component<AppDependency> {
    fileprivate(set) static var instance: AppComponent!
}

extension AppComponent {
    var applicationInfo: ApplicationInfo {
        shared {
            let bundle = Bundle.main
            return ApplicationInfo(
                version: bundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String,
                build: bundle.object(forInfoDictionaryKey: "CFBundleVersion") as! String,
                sourceCodeURL: URL(string: "https://github.com/droibit/swiftui-todo-app")!
            )
        }
    }
}

extension CoreComponent {
    var appComponent: AppComponent {
        AppComponent(parent: self)
    }
}

// MARK: - Initialize

func initializeAppComponent() {
    guard AppComponent.instance == nil else {
        return
    }
    registerProviderFactories()

    let appComponent = CoreComponent().appComponent
    appComponent.tasksRepository.initialize()
    //    _ = appComponent.tasksRepository.createTask(title: "Task1", description: "").subscribe()
    //    _ = appComponent.tasksRepository.createTask(title: "Task2", description: "").subscribe()
    //    _ = appComponent.tasksRepository.createTask(title: "Task3", description: "").subscribe()

    AppComponent.instance = appComponent
}
